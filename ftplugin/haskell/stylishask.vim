if !exists("g:stylishask_on_save")
    let g:stylishask_on_save = 1
endif

if !exists("g:stylishask_command") && executable("stylish-haskell")
    let g:stylishask_command = "stylish-haskell"
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


function! stylishask#Stylishask() range
    if !exists("g:stylishask_command")
        echomsg "Stylish-haskell not found in $PATH, did you install it?
                    \ (stack install stylish-haskell)"
        return
    endif

    " Write the buffer to stylish-haskell, rather than having it use the
    " file on disk, because that file might not have been created yet!
    silent! exe "w !" . g:stylishask_command . " > /dev/null 2>&1"

    if v:shell_error
        echohl WarningMsg
        echo "Stylish-haskell: Parsing error\n"
        echohl None
    else
        let l:config_file_opt = ""
        if exists("g:stylishask_config_file")
          let l:config_file_opt = " --config " . g:stylishask_config_file
        endif

        silent! exe "undojoin"

        silent! exe "keepjumps " . a:firstline . "," . a:lastline . "!" . g:stylishask_command . l:config_file_opt
    endif

    call winrestview(b:winview)
endfunction

function! stylishask#StylishaskOnSave()
    if g:stylishask_on_save == 1
        let b:winview = winsaveview()
        exe "%call stylishask#Stylishask()"
    endif
endfunction


augroup stylishask
    autocmd!
    autocmd BufWritePre *.hs call stylishask#StylishaskOnSave()
augroup END


command! -range=% Stylishask exe "let b:winview = winsaveview() | <line1>, <line2>call stylishask#Stylishask()"
command! StylishaskEnable exe "call stylishask#StylishaskEnable()"
command! StylishaskDisable exe "call stylishask#StylishaskDisable()"
command! StylishaskToggle exe "call stylishask#StylishaskToggle()"
