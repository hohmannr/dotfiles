" Load legacy .vimrc
set runtimepath^=/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Hide '~' at the end of the file
:hi NonText ctermfg=123

" Load UltiSnips path
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
