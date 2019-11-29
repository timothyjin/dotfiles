let mapleader=" "

call plug#begin('~/.vim/plugged')
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'
Plug 'dpelle/vim-LanguageTool'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'

Plug 'sheerun/vim-polyglot'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'vimwiki/vimwiki'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'
" Plug 'neovimhaskell/haskell-vim'
call plug#end()

" ----- Themes ----- "
color peachpuff
let g:airline_theme='serene'
map <leader>t :AirlineTheme<Space>

" ----- Basics ----- "
set nocompatible
filetype plugin indent on
syntax on
set encoding=utf-8
set number relativenumber
set splitbelow splitright
set clipboard+=unnamedplus

" ----- Tabs ----- "
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" ----- Autocompletion ----- "
set wildmode=longest,list,full

" ----- Disable automatic commenting ----- "
autocmd FileType * setlocal formatoptions-=c formatoptions -=r formatoptions-=o

" ----- Split navigation ----- "
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" ----- Leader key bindings ----- "
map <leader>r :set relativenumber!<CR>
map <leader>u :PlugUpdate<CR>
map <leader>o :setlocal spell! spelllang=en_us<CR>
map <leader>p :!opout <c-r>%<CR><CR>
map <leader>f :Files<CR>
map <leader>g :Goyo \| set linebreak!<CR>
map <leader>c :w! \| !compiler <c-r>%<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>/ gcc

" ----- Make fzf look through hidden directories as well ----- "
let $FZF_DEFAULT_COMMAND="find ~ -type f -printf '%P\n'"

" ----- Grammar check (LanguageTool) ----- "
let g:languagetool_jar='/usr/share/java/languagetool/languagetool-commandline.jar'
let g:languagetool_lang="en-US"
map <leader>l :LanguageToolCheck<CR>
map <leader>k :LanguageToolClear<CR>

" ----- Clean out TeX build files ----- "
autocmd VimLeave *.tex !texclear %

" ----- Read files as desired ----- "
autocmd BufRead,BufNewFile *.tex set filetype=tex

" ----- Run xrdb whenever Xresources is updated ----- "
autocmd BufWritePost ~/.Xresources !xrdb %

" ----- Guides ----- " [Deletes guide after finding it.]
inoremap \<leader> <Esc>/<++><Enter><Esc>4s
vnoremap \<leader> <Esc>/<++><Enter><Esc>4s
map \<leader> <Esc>/<++><Enter><Esc>4s

" ----- LaTeX ----- "
autocmd FileType tex inoremap ;z <Space>\\<Enter>
autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>T{i
autocmd FileType tex inoremap ;it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap ;em \emph{}<++><Esc>T{i
autocmd FileType tex inoremap ;env \begin{}<Enter><++><Enter>\end{<++>}<Enter><Enter><++><Esc>4kf}i
autocmd FileType tex inoremap ;ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ;ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ;l <Enter><Backspace>\item<Space>
autocmd FileType tex inoremap ;ch \chapter{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;s1 \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;s2 \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;s3 \subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;up \usepackage{}<Enter><++><Esc>kf}i

autocmd FileType tex,rmd inoremap ;n $$<++><Esc>2T$i
autocmd FileType tex,rmd inoremap ;m <Tab>$$<Space><Space>$$<Enter><Backspace><++><Esc>k4li
autocmd FileType tex,rmd inoremap ;sup ^{}<++><Esc>T{i
autocmd FileType tex,rmd inoremap ;sub _{}<++><Esc>T{i
autocmd FileType tex,rmd inoremap ;( \left(<Space><Space>\right)<Space><++><Esc>T(li
autocmd FileType tex,rmd inoremap ;[ \left[<Space><Space>\right]<Space><++><Esc>T[li
autocmd FileType tex,rmd inoremap ;fr \frac{}{<++>}<++><Esc>2T{i
autocmd FileType tex,rmd inoremap ;sum \sum_{}^{<++>}<Space><++><Esc>2T{i
autocmd FileType tex,rmd inoremap ;dc ,<Space>\dotsc,<Space>
autocmd FileType tex,rmd inoremap ;db <Esc>vya<Space>\dotsb<Space><Esc>pa<Space>
autocmd FileType tex,rmd inoremap ;int \int_{}^{<++>}<Space><++><Esc>2T{i
autocmd FileType tex,rmd inoremap ;bb \mathbb{}<++><Esc>T{i
autocmd FileType tex,rmd inoremap ;cal \mathcal{}<++><Esc>T{i
autocmd FileType tex,rmd inoremap ;si \SI{}{<++>}<++><Esc>2T{i

" Word count in .tex and .rmd
autocmd FileType tex,rmd map <leader>w :w !detex \| wc -w<CR>

" ----- Markdown ----- "
autocmd FileType markdown,rmd inoremap ;b ****<++><Esc>F*hi
autocmd FileType markdown,rmd inoremap ;i **<++><Esc>F*i
autocmd FileType markdown,rmd inoremap ;u __<++><Esc>F_i
autocmd FileType markdown,rmd inoremap ;h1 #<Space><Enter><++><Esc>kA
autocmd FileType markdown,rmd inoremap ;h2 ##<Space><Enter><++><Esc>kA
autocmd FileType markdown,rmd inoremap ;h3 ###<Space><Enter><++><Esc>kA
autocmd FileType rmd inoremap ;pr ---<Enter><Enter>---<Enter><Enter><++><Esc>3kA
autocmd FileType rmd inoremap ;cs ``<++><Esc>F`i
autocmd FileType rmd inoremap ;cc ```<Enter><++><Enter>```<Enter><++><Esc>4kA

" ----- Vimwiki ----- "
autocmd FileType vimwiki inoremap ;b **<++><Esc>F*i
autocmd FileType vimwiki inoremap ;i __<++><Esc>F_i
autocmd FileType vimwiki inoremap ;h1 =<Space><Space>=<Enter><++><Esc>k02li
autocmd FileType vimwiki inoremap ;h2 ==<Space><Space>==<Enter><++><Esc>k03li
autocmd FileType vimwiki inoremap ;h3 ===<Space><Space>===<Enter><++><Esc>k04li
autocmd FileType vimwiki inoremap ;ul *<Space>
autocmd FileType vimwiki inoremap ;l <Enter><Tab>-<Space>
autocmd FileType vimwiki inoremap ;n $$<++><Esc>2T$i
autocmd FileType vimwiki inoremap ;cs ``<++><Esc>F`i

" ----- Haskell ----- "
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
