" plugin management via Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" PLUGINS
Plugin 'VundleVim/Vundle.vim'

Plugin 'lervag/vimtex'
Plugin 'SirVer/ultisnips'
Plugin 'scrooloose/nerdtree'
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-fugitive'

call vundle#end()

" Plugin setup
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:tex_flavor = 'latex'

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1

let g:indentLine_char = '┆'
let g:indentLine_color_term = 238

" set how many suggestions will be displayed by YouCompleteMe
set pumheight=1

" setting line numbers
set rnu nu

" setting syntax highlighting
syntax on

" setting color theme
colorscheme peachpuff

" highlighting cursor line
set cursorline
hi CursorLine cterm=None term=None ctermbg=234

" highlighting visual mode text color
hi Visual cterm=None ctermbg=0 ctermfg=None guibg=Grey11

" changing conceal character highlighting
hi Conceal cterm=None term=None ctermbg=None

" changing status line color
hi StatusLine ctermfg=234 ctermbg=252

" changing vertical split line
hi VertSplit ctermfg=234
set fillchars+=vert:\ 

" changing idle split's status line color
hi StatusLineNC ctermfg=234 ctermbg=252

" changing highlighting on pop up menu (mainly for YouCompleteMe Plugin)
hi Pmenu ctermfg=252 ctermbg=234 

" hide NERDTree '/' after directory
augroup nerdtreehidecwd
	autocmd!
	autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
augroup end

" hide cursor line in inactive window
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" replace tabs with spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" indentation rules
set breakindent
set breakindentopt=shift:4,min:40,sbr

" File preferences
" Latex
au BufReadPost,BufNewFile *.tex call vimtex#init()

" C++
"set cindent
"set cinoptions=g-1

" Command preferences
" Latex
ab vtc VimtexCompile

" Quick typo fixing
autocmd FileType latex setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Display typos as red text with underline
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=88

" custom tab highlighting
hi! TabChar ctermbg=NONE
au BufReadPost,BufNewFile * syn match TabChar " "

" Switch buffer shortcut
nmap <C-w> :bn<CR>

" turn on auto-indent
set autoindent
set smartindent
