" setting color variables
let g:lightbg = "black"
let g:cursorcolor = "magenta"

" plugin management via Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'VundleVim/Vundle.vim'

Plugin 'lervag/vimtex'
Plugin 'SirVer/ultisnips'
Plugin 'scrooloose/nerdtree'
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'bagrat/vim-buffet'
Plugin 'ryanoasis/vim-devicons'

call vundle#end()

" Plugin setup
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=2
let g:tex_conceal='abdmg'
let g:tex_flavor = 'latex'

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

map <C-space> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1

let g:indentLine_char = '┆'
let g:indentLine_color_term = "black"

let g:buffet_tab_icon = ''
let g:buffet_new_buffer_name = ' '
let g:buffet_modified_icon = ' '
let g:buffet_right_trunc_icon = ' '
let g:buffet_left_trunc_icon = ' '
let g:buffet_separator = get(g:, "buffet_separator", "")
let g:buffet_noseparator = get(g:, "buffet_noseparator", "")

function! g:BuffetSetCustomColors()
    exe 'hi! BuffetCurrentBuffer cterm=none ctermbg=' . g:lightbg . ' ctermfg=white'
    exe 'hi! BuffetActiveBuffer cterm=none ctermbg=' . g:lightbg . ' ctermfg=white'
    hi! BuffetBuffer cterm=none ctermbg=none ctermfg=lightgrey
    hi! BuffetTab cterm=none ctermbg=none ctermfg=lightgrey
    hi! BuffetTrunc cterm=none ctermbg=none ctermfg=lightgrey
    hi! buffet_noseperator cterm=none ctermbg=none ctermfg=green
endfunction

" set how many suggestions will be displayed by YouCompleteMe
set pumheight=4

" setting line numbers
set rnu nu

" setting syntax highlighting
syntax on

" setting color theme
colorscheme peachpuff

" highlighting cursor line
set cursorline
exe 'hi CursorLine cterm=none term=none ctermbg='. g:lightbg

" highlighting comments as italic
hi Comment cterm=italic

" highlighting visual mode text color
exe 'hi Visual cterm=none ctermbg=' . g:lightbg

" changing conceal character highlighting
hi Conceal cterm=none ctermbg=none ctermfg=white

" changing row number color
exe 'hi LineNr ctermfg=' . g:lightbg . ' ctermbg=none cterm=none'
exe 'hi CursorLineNr ctermfg=' . g:cursorcolor . ' ctermbg=none cterm=none'

" changing vertical split line
exe 'hi VertSplit ctermfg=' . g:lightbg
set fillchars+=vert:\ 

" changing idle split's status line color
exe 'hi StatusLineNC ctermfg=' . g:lightbg . ' ctermbg=none'

" changing highlighting on pop up menu (mainly for YouCompleteMe Plugin)
exe 'hi Pmenu ctermfg=252 ctermbg=' . g:lightbg

" changing '~' color for non existing lines at the end of file
exe 'hi NonText ctermfg=' . g:lightbg

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
augroup end

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

" command preferences
" Latex
ab vtc VimtexCompile

" quick typo fixing
autocmd FileType latex setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" display typos as red text with underline
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=88

" custom tab highlighting
hi! TabChar ctermbg=none
au BufReadPost,BufNewFile * syn match TabChar " "

" make navigation easier by going from line to line and centering it
nnoremap j gjzz
nnoremap k gkzz

" switch buffer shortcut
nmap <C-m> :bn<CR>
nmap <C-n> :bp<CR>

" close buffer shortcut
nmap <C-w> :bd!<CR>

" save shortcut
:nmap <C-s> :w!<cr>
:imap <C-s> <esc>:w!<cr>

" find and replace shortcut
:nmap <C-f> :%s/

" enable buffer switching even when buffer is not saved
set hidden

" turn on auto-indent
set autoindent
set smartindent

" setting filetype for .Xresource config files for syntaxhighlighting
au BufRead,BufNewFile *.xres set filetype=xdefaults

