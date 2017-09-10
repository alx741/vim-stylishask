if !exists("g:stylishask_on_save")
    let g:stylishask_on_save = 1
endif


function! stylishask#StylishaskEnable()
    let g:stylishask_on_save = 1
endfunction
function! stylishask#StylishaskDisable()
    let g:stylishask_on_save = 0
endfunction
function! stylishask#StylishaskToggle()
    let g:stylishask_on_save = !g:stylishask_on_save
endfunction


function! stylishask#Stylishask()
    let l:winview = winsaveview()

    if !executable("stylish-haskell")
        echomsg "Stylish-haskell not found in $PATH, did you installed it?
                    \ (stack install stylish-haskell)"
        return
    endif

    " Write the buffer to stylish-haskell, rather than having it use the
    " file on disk, because that file might not have been created yet!
    silent! w !stylish-haskell > /dev/null 2>&1

    if v:shell_error
        echohl WarningMsg
        echo "Stylish-haskell: Parsing error\n"
        echohl None
    else
        " let l:indent_opt = ""
        " if exists("g:stylishask_indent_size")
        "   let l:indent_opt = " --indent-size " . g:stylishask_indent_size
        " endif

        " let l:line_length_opt = ""
        " if exists("g:stylishask_line_length")
        "   let l:line_length_opt = " --line-length " . g:stylishask_line_length
        " endif

        silent! exe "undojoin"
        " silent! exe "keepjumps %!stylish-haskell" . l:indent_opt . l:line_length_opt
        silent! exe "keepjumps %!stylish-haskell" . l:indent_opt . l:line_length_opt
    endif

    call winrestview(l:winview)
endfunction

function! stylishask#StylishaskOnSave()
    if g:stylishask_on_save == 1
        call stylishask#Stylishask()
    endif
endfunction


augroup hindent
    autocmd!
    autocmd BufWritePre *.hs call stylishask#StylishaskOnSave()
augroup END


command! Hindent exe "call stylishask#Stylishask()"
command! HindentEnable exe "call stylishask#StylishaskEnable()"
command! HindentDisable exe "call stylishask#StylishaskDisable()"
command! HindentToggle exe "call stylishask#StylishaskToggle()"
