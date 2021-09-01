{-# LANGUAGE DeriveDataTypeable, TypeSynonymInstances, MultiParamTypeClasses #-}

import XMonad hiding ( (|||) )
import qualified XMonad.StackSet as W

import XMonad.Actions.PhysicalScreens
import XMonad.Actions.SwapWorkspaces
import XMonad.Actions.UpdatePointer

import qualified XMonad.Hooks.DynamicLog as DLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook

import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.Dwindle
import XMonad.Layout.MultiToggle
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.TwoPane

import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce
import XMonad.Util.XUtils

import Control.Monad
import Data.List
import Data.Maybe (maybeToList)
import qualified Data.Map as M
import Data.Monoid

import Foreign.C.String
import System.Exit

import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

import Colors as Colors

darkBlack   = Colors.color0
black       = Colors.color8
darkRed     = Colors.color1
red         = Colors.color9
darkGreen   = Colors.color2
green       = Colors.color10
darkYellow  = Colors.color3
yellow      = Colors.color11
darkBlue    = Colors.color4
blue        = Colors.color12
darkMagenta = Colors.color5
magenta     = Colors.color13
darkCyan    = Colors.color6
cyan        = Colors.color14
darkWhite   = Colors.color7
white       = Colors.color15
fullBlack   = "#ff000000"
transparent = "#00000000"

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "st"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

myScratchpads =
    [ NS "terminal" "$TERMINAL -c _nsp" (className =? "_nsp") (customFloating $ W.RationalRect 0.25 0.25 0.5 0.5) ]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = darkBlack
myFocusedBorderColor = darkBlue

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys = \conf -> mkKeymap conf $
    [ ("M-<Return>",       spawn $ XMonad.terminal conf)
    , ("M-`",              spawn "rofi -modi emoji -show")
    , ("M-<Esc>",          spawn "xmonad --recompile && xmonad --restart")
    , ("M-<Space>",        sendMessage NextLayout)
    , ("M-S-<Space>",      setLayout $ XMonad.layoutHook conf)
    , ("M-<Backspace>",    spawn "prompt 'Shutdown?' 'sudo shutdown -h now'")
    , ("M-S-<Backspace>",  spawn "prompt 'Reboot?' 'sudo reboot'")
    , ("M-<Tab>",          windows W.focusDown)
    , ("M-S-<Tab>",        windows W.focusUp)
    , ("M-q",              kill)
    , ("M-S-q",            io (exitWith ExitSuccess))
    , ("M-w",              spawn "firefox")
    , ("M-S-w",            spawn "firefox --private-window")
    , ("M-e",              spawn "$TERMINAL -n $EDITOR -e $EDITOR -c Files")
    , ("M-r",              spawn "$TERMINAL -n $FILE -e $FILE")
    , ("M-t",              withFocused $ windows . W.sink)
    , ("M-y",              sendMessage $ JumpToLayout $ myLayoutNames !! 1)
    , ("M-u",              sendMessage $ JumpToLayout $ myLayoutNames !! 2)
    , ("M-i",              sendMessage $ JumpToLayout $ myLayoutNames !! 3)
    , ("M-o",              sendMessage $ JumpToLayout $ myLayoutNames !! 4)
    , ("M-p",              spawn "$TERMINAL -n ncmpcpp -e ncmpcpp")
    , ("M-S-p",            spawn "pavucontrol")
    , ("M-a",              spawn "$TERMINAL -n float_calcurse -e calcurse")
    , ("M-s",              spawn "$TERMINAL -n float_mixer -e pulsemixer")
    , ("M-S-s",            spawn "slack")
    , ("M-d",              spawn "$LAUNCHER")
    , ("M-S-d",            spawn "dmenu_file")
    , ("M-f",              sendMessage $ Toggle RNBFULL)
    , ("M-S-f",            sendMessage $ Toggle RMIRROR)
    , ("M-g",              spawn "$TERMINAL -n ytop -e ytop -p")
    , ("M-h",              onPrevNeighbour def W.view)
    , ("M-S-h",            onPrevNeighbour def W.shift >> onPrevNeighbour def W.view)
    , ("M-j",              windows W.focusDown)
    , ("M-S-j",            windows W.swapDown)
    , ("M-k",              windows W.focusUp)
    , ("M-S-k",            windows W.swapUp)
    , ("M-l",              onNextNeighbour def W.view)
    , ("M-S-l",            onNextNeighbour def W.shift >> onNextNeighbour def W.view)
    -- , ("M-z",              )
    , ("M-x",              namedScratchpadAction myScratchpads "terminal")
    , ("M-c",              spawn "rofi-calc")
    , ("M-S-c",            spawn "$TERMINAL -n float_calc -e bc -ql")
    , ("M-v",              spawn "showclip")
    , ("M-S-v",            spawn "$TERMINAL -n cava -e cava")
    , ("M-b",              sendMessage ToggleStruts)
    , ("M-n",              spawn "$TERMINAL -n nmtui -e nmtui")
    , ("M-m",              windows W.focusMaster)
    , ("M-S-m",            windows W.shiftMaster)
    , ("M-,",              sendMessage (IncMasterN 1))
    , ("M-S-,",            sendMessage Shrink)
    , ("M-.",              sendMessage (IncMasterN (-1)))
    , ("M-S-.",            sendMessage Expand)
    , ("M-<F1>",           spawn "volctl mute")
    , ("M-<F2>",           spawn "volctl down 2")
    , ("M-<F3>",           spawn "volctl up 2")
    , ("M-<F4>",           spawn "pactl set-source-mute 1 toggle")
    , ("M-<F5>",           spawn "brillo -U 10")
    , ("M-<F6>",           spawn "brillo -A 10")
    , ("M-<F7>",           spawn "monon-select")
    , ("M-S-<F7>",         spawn "prompt 'Switch to laptop display?' monoff")
    , ("<XF86AudioMute>",          spawn "volctl mute")
    , ("<XF86AudioLowerVolume>",   spawn "volctl down 2")
    , ("<XF86AudioRaiseVolume>",   spawn "volctl up 2")
    , ("<XF86AudioMicMute>",       spawn "pactl set-source-mute 1 toggle")
    , ("<XF86MonBrightnessDown>",  spawn "brillo -U 10")
    , ("<XF86MonBrightnessUp>",    spawn "brillo -A 10")
    , ("<XF86Display>",            spawn "monon-select")
    , ("S-<XF86Display>",          spawn "prompt 'Switch to laptop display?' monoff")
    , ("<Print>",                  spawn "maim -u ~/Pictures/$(date +%s).png")
    , ("S-<Print>",                spawn "maim -u -s ~/Pictures/$(date +%s).png")
    ]
    ++
    [ (m ++ i, windows $ f j)
        | (i, j) <- zip (map show [1..9]) (XMonad.workspaces conf)
        , (m, f) <- [("M-", W.view), ("M-S-", W.shift), ("M-C-", swapWithCurrent) ]
    ]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    , ((modm, button4), (\_ -> windows W.focusUp))
    , ((modm, button5), (\_ -> windows W.focusDown))
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = smartBorders
    . mkToggle1 RNBFULL
    . avoidStruts
    . mkToggle1 RMIRROR
    $ bsp ||| tiled ||| twopane ||| threecol ||| fib
    where
        bsp = renamed [Replace $ myLayoutNames !! 0] $ spacing $ emptyBSP
        tiled = renamed [Replace $ myLayoutNames !! 1] $ spacing $ ResizableTall nmaster delta ratio []
        twopane = renamed [Replace $ myLayoutNames !! 2] $ spacing $ TwoPane delta ratio
        threecol = renamed [Replace $ myLayoutNames !! 3] $ spacing $ ThreeColMid 1 delta ratio
        fib = renamed [Replace $ myLayoutNames !! 4] $ spacing $ Spiral L XMonad.Layout.Dwindle.CW (3/2) (11/10)

        -- Spacing between the edges of the screen and windows
        spacing = spacingRaw True (Border 0 5 5 5) True (Border 5 5 5 5) True
        -- The default number of windows in the master pane
        nmaster = 1
        -- Default proportion of screen occupied by master pane
        ratio   = 1/2
        -- Percent of screen to increment by when resizing panes
        delta   = 5/100

-- Renamed NBFULL transformer
data RNBFULL = RNBFULL deriving (Read, Show, Eq, Typeable)
instance Transformer RNBFULL Window where
    transform _ x k = k (renamed [Replace "全"] $ noBorders Full) (const x)

-- Renamed MIRROR transformer
data RMIRROR = RMIRROR deriving (Read, Show, Eq, Typeable)
instance Transformer RMIRROR Window where
    transform _ x k = k (renamed [CutWordsLeft 1, Prepend "反"] $ Mirror x) (const x)

myLayoutNames = ["二","高", "双", "中", "螺"]

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeOne $
    [ transience
    , isDialog                       -?> doFloat
    , appName =? "float_calc"        -?> doCenterFloat
    , appName =? "float_calcurse"    -?> doCenterFloat
    , appName =? "float_mixer"       -?> doCenterFloat
    , appName =? "forticlientsslvpn" -?> doCenterFloat
    , appName =? "desktop_window"    -?> doIgnore
    , isFullscreen                   -?> doFullFloat
    , return True -?> namedScratchpadManageHook myScratchpads <+> insertPosition Below Newer ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = composeAll
    [ fullscreenEventHook ]

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook :: D.Client -> DLog.PP
myLogHook dbus = namedScratchpadFilterOutWorkspacePP $ def
    { DLog.ppOutput = dbusOutput dbus
    , DLog.ppCurrent = \s -> (ppFg darkBlack) . (ppBg white) . (ppAct s) . ppPad $ s
    , DLog.ppVisible = \s -> (ppFg darkBlack) . (ppBg darkWhite) . (ppAct s) . ppPad $ s
    , DLog.ppHidden = \s -> (ppBg black) . (ppAct s) . ppPad $ s
    , DLog.ppVisibleNoWindows = return $ \s -> (ppFg darkBlack) . (ppBg darkWhite) . (ppAct s) . ppPad $ s
    , DLog.ppHiddenNoWindows = \s -> (ppAct s) . ppPad $ s
    , DLog.ppUrgent = (ppFg darkBlack) . (ppBg red) . ppPad
    , DLog.ppSep = (ppFg transparent) $ "."
    , DLog.ppWsSep = (ppFg transparent) "."
    , DLog.ppTitle = ppPad . DLog.shorten 65
    , DLog.ppLayout = (ppFg darkBlack) . (ppBg cyan) . ppPad
    }

dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal objectPath interfaceName memberName) {
            D.signalBody = [D.toVariant $ UTF8.decodeString str]
        }
    D.emit dbus signal
    where
        objectPath = D.objectPath_ "/org/xmonad/Log"
        interfaceName = D.interfaceName_ "org.xmonad.Log"
        memberName = D.memberName_ "Update"

ppPad :: String -> String
ppPad = DLog.pad . DLog.pad

ppBg :: String -> (String -> String)
ppBg bg = DLog.wrap ("%{B" ++ bg ++ "}") "%{B-}"

ppFg :: String -> (String -> String)
ppFg fg = DLog.wrap ("%{F" ++ fg ++ "}") "%{F-}"

ppAct :: String -> (String -> String)
ppAct s = DLog.wrap ("%{A1:wmctrl -s " ++ i ++ ":}") "%{A}"
    where
        d = read s :: Integer
        i = show $ d - 1

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    spawn "launch-polybar xmonad &"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main :: IO ()
main = do
    dbus <- D.connectSession
    D.requestName dbus (D.busName_ "org.xmonad.Log")
        [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
    xmonad $ docks $ ewmh def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = DLog.dynamicLogWithPP (myLogHook dbus) >> updatePointer (0.5, 0.5) (0, 0),
        startupHook        = myStartupHook >> addEWMHFullscreen
    }

addEWMHFullscreen :: X ()
addEWMHFullscreen   = do
    wms <- getAtom "_NET_WM_STATE"
    wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
    mapM_ addNETSupported [wms, wfs]

addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
    r               <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a               <- getAtom "ATOM"
    liftIO $ do
       sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
       when (fromIntegral x `notElem` sup) $
         changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]
