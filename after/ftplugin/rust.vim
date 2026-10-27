" general

setlocal makeprg=cargo

" Rust documentation checking

function! RustDocs()
    let l:word = expand("<cword>")
    :call RustMan(word)
endfunction

function! RustMan(word)
    let l:command  = ':split | :te rusty-man ' . a:word
    execute command
endfunction

:command! -nargs=1 Rman call RustMan(<f-args>)

" commands
augroup RustManTerm
    autocmd!
    autocmd TermClose term://*:rusty-man* q
augroup END

" keybindings
" nmap <S-l> :call RustDocs()<CR>
" map <C-b> :!clear; cargo check<CR>

" abbreviations
abclear <buffer>
"ia dd #[derive(Debug)]

" mapping
nnoremap <buffer> <F5> :w<CR>:!cargo build<CR>
nnoremap <buffer> <F6> :w<CR>:!cargo run<CR>
nnoremap <buffer> <F7> :w<CR>:!cargo clean<CR>

" disable formatting
" autocmd! FORMATTING
