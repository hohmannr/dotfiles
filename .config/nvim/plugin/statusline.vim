" ┌─────────────────┐
" │ PILL STATUSLINE │
" └─────────────────┘
" created in  &  by @hohmannr with 

" ┌───────────────┐
" │ General Setup │
" └───────────────┘
" always display statusline
set laststatus=2

" ┌───────┐
" │ Icons │
" └───────┘
let g:LeftPowerlineGlyph = ""
let g:RightPowerlineGlyph = ""
let g:StatusLineElemSpace = " "
let g:StatusLineVerticalSpace = " %="
let g:GitBranchIcon = ""
let g:FileNameIcon = ""
let g:ModifiedIcon = "●"
let g:VimNormalModeIcon = "N"
let g:VimInsertModeIcon = "I"
let g:VimVisualModeIcon = "V"
let g:VimReplaceModeIcon = "R"
let g:VimCommandModeIcon = "C"
let g:VimTermModeIcon = "T"

" ┌──────────┐
" │ Coloring │
" └──────────┘
hi StatusLine cterm=none ctermfg=none ctermbg=none
hi StatusLineElem cterm=none ctermfg=none ctermbg=black
hi StatusLineElemPowerline cterm=none ctermfg=black ctermbg=none
hi StatusLineSpaceElem cterm=none ctermfg=none ctermbg=none
hi GitBranchElem cterm=none ctermfg=green ctermbg=black
hi FileNameElem cterm=none ctermfg=blue ctermbg=black
hi VimModeElem cterm=none ctermfg=white ctermbg=black
hi ScrollProgressElem cterm=none ctermfg=white ctermbg=black
hi FileEncodingElem cterm=italic ctermfg=white ctermbg=black
hi CurrentLinePosElem cterm=none ctermfg=white ctermbg=black
hi ReadOnlyElem cterm=none ctermfg=red ctermbg=black

" ┌───────────┐
" │ Functions │
" └───────────┘
function! GitBranch()
    try
        let l:branch = fugitive#head()
        return l:branch
    catch /.*/
        echom ""
    endtry

    return -1
endfunction

function! FileName()
    let l:fname = expand("%:t")

    " check if file was modified, if this is the case then use the modified
    " icon and change color of the file name to indicate the change
    if &mod
        let l:fname.=" " . g:ModifiedIcon
        hi FileNameElem ctermfg=yellow
    else
        hi FileNameElem ctermfg=blue
    endif

    return l:fname
endfunction

function! VimMode()
    let l:mode = mode()

    if l:mode == "n"
        hi VimModeElem ctermfg=white
        let modeString = g:VimNormalModeIcon
    elseif l:mode == "i"
        hi VimModeElem ctermfg=red
        let modeString = g:VimInsertModeIcon
    elseif l:mode == "R"
        hi VimModeElem ctermfg=blue
        let modeString = g:VimReplaceModeIcon
    elseif l:mode == "v" || l:mode == "V" || l:mode == "\<C-V>"
        hi VimModeElem ctermfg=magenta
        let l:modeString = g:VimVisualModeIcon
    elseif l:mode == "c"
        hi VimModeElem ctermfg=yellow
        let l:modeString = g:VimCommandModeIcon
    elseif l:mode == "t"
        hi VimModeElem ctermfg=yellow
        let l:modestring = g:VimTermModeIcon
    else
        let l:modeString = " "
    endif

    return l:modeString
endfunction

function! ScrollProgress()
    let l:scroll_percent = line('.') * 100 / line('$') . '%'

    return scroll_percent
endfunction

function! FileEncoding()
    let l:encoding = "" . &fenc
    if l:encoding == ""
        return -1
    else
        return l:encoding
    endif
endfunction

function! CurrentLinePos()
    let l:line_pos = "" . col(".")
    
    return l:line_pos
endfunction

function! ReadOnly()
    let l:readonly = ""

    if &readonly || !&modifiable
        return "Read Only"
    else
        return -1
    endif
endfunction

function! BuildElemFromDict(elemDict)
    let l:elem = ""
    let l:elem.="%#" . a:elemDict["highlight_id"] . "#"

    " checking for icon
    if !a:elemDict["hasIcon"]
        let l:elem.=" "
    else
        let l:elem.=" " . a:elemDict["icon"] . " "
    endif

    let l:elem.="%{" . a:elemDict["func"] . "} "

    return l:elem
endfunction

function! BuildStatusLineFromDict(buildDict)
    let l:currentPrio = 0
    let l:statusline = ""
    for l:key in keys(a:buildDict)
        let l:elem = a:buildDict[l:key]
        " concerning spaces
        if has_key(l:elem, "space")
            if l:elem["space"] == "elemSpace"
                let l:statusline.=g:StatusLineElemSpace
            elseif l:elem["space"] == "vertSpace"
                let l:statusline.=g:StatusLineVerticalSpace
            endif

        " concerning elements in pills
        else
            let l:invalidcount = 0
            for l:i in range(len(keys(l:elem)) - 1)
                if l:elem[l:i]["dynamic"]
                    let l:out = execute("echom " . l:elem[l:i]["func"])
                    if split(l:out) == ["-1"]
                        let l:invalidcount = l:invalidcount + 1
                    endif
                endif
            endfor

            if l:invalidcount == len(keys(l:elem)) - 1
                break
            endif

            let l:statusline.="%#StatusLineElemPowerline#" . g:LeftPowerlineGlyph
            for l:i in range(len(keys(l:elem)) - 1)
                let l:statusline.=BuildElemFromDict(l:elem[l:i])
            endfor
            let l:statusline.="%#StatusLineElemPowerline#" . g:RightPowerlineGlyph
        endif
    endfor

    return l:statusline
endfunction


" ┌──────────┐
" │ Elements │
" └──────────┘
" Build order dictonary used for building the elements of the statusline
let g:StatusLineBuildOrderDict = {
    \ 0: {
        \ 0: {
            \ "id": "vim_mode",
            \ "highlight_id": "VimModeElem",
            \ "hasIcon": 0,
            \ "func": "VimMode()",
            \ "dynamic": 0,
        \ },
        \ 1: {
            \ "id": "file_name",
            \ "highlight_id": "FileNameElem",
            \ "hasIcon": 1,
            \ "icon": g:FileNameIcon,
            \ "func": "FileName()",
            \ "dynamic": 0,
        \ },
        \ "priority": 0,
    \ },
    \ 1: { "space": "elemSpace" },
    \ 2: {
        \ 0: {
            \ "id": "git_branch",
            \ "highlight_id": "GitBranchElem",
            \ "hasIcon": 1,
            \ "icon": g:GitBranchIcon,
            \ "func": "GitBranch()",
            \ "dynamic": 1,
        \ },
        \ "priority": 1,
    \ },
    \ 3: { "space": "vertSpace" },
    \ 4: {
        \ 0: {
            \ "id": "current_line_position",
            \ "highlight_id": "CurrentLinePosElem",
            \ "hasIcon": 0,
            \ "func": "CurrentLinePos()",
            \ "dynamic": 0,
        \ },
        \ "priority": 2,
    \ },
    \ 5: { "space": "elemSpace" },
    \ 6: {
        \ 0: {
            \ "id": "scroll_progress",
            \ "highlight_id": "ScrollProgressElem",
            \ "hasIcon": 0,
            \ "func": "ScrollProgress()",
            \ "dynamic": 0,
        \ },
        \ "priority": 3,
    \ },
    \ 7: { "space": "elemSpace" },
    \ 8: {
        \ 0: {
            \ "id": "file_encoding",
            \ "highlight_id": "FileEncodingElem",
            \ "hasIcon": 0,
            \ "func": "FileEncoding()",
            \ "dynamic": 1,
        \ },
        \ "priority": 5,
    \ },
    \ 9: { "space": "elemSpace" },
    \ 10: {
        \ 0: {
            \ "id": "read_only",
            \ "highlight_id": "ReadOnlyElem",
            \ "hasIcon": 0,
            \ "func": "ReadOnly()",
            \ "dynamic": 1,
        \ },
        \ "priority": 6,
    \ },
\}

" Rendering
set statusline=""
set statusline+=%!BuildStatusLineFromDict(g:StatusLineBuildOrderDict)

