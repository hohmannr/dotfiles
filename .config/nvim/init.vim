" VIM CONFIGURATION
" load legacy .vimrc
set runtimepath^=/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" load UltiSnips path
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

" prevent cursor jumping (too much)

" increase max. memory for large file with syntax highlighting
set maxmempattern=20000

" jump to completing bracket
set showmatch
set matchtime=2
" always show cursor position set ruler 
" read a file changed out side of vim again
set autoread

" plugin start working better, who knows why...
set magic

" highlight search results
set hlsearch

" set filetypes, in this case unix is standard
set ffs=unix,mac,dos

" wrap lines (line continues in next line when window ends)
set wrap

" do not use swap files for buffer (changes made in same file will overwrite each other!)
set noswapfile

" do not make backups before writing a file
set nobackup
set nowritebackup

" FILES
" proivdes TAB completion for files
set path+=**

" display all matching files while TAB completing
set wildmenu

" exclude node_modules from searching with :find
set wildignore+=**/node_modules/**

" MAPPINGS
" make TAB clear search highlichts in normal mode
map <Tab> :noh<CR>

" PLUGIN SETUP
let NERDTreeStatusline=" "

" change vim's error message
hi Error cterm=italic ctermfg=red ctermbg=none
hi ErrorMsg cterm=italic ctermfg=red ctermbg=none

" hide mode info
set noshowmode
