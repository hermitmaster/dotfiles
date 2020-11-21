packadd rust.vim

" Key Mapping: {{{
map <localleader>s <Plug>(rust-def-split)
map <localleader>x <Plug>(rust-def-vertical)
map <localleader>cb :Dispatch cargo build<CR>
map <localleader>cc :Dispatch cargo clean<CR>
map <localleader>cd :Dispatch cargo doc<CR>
map <localleader>cf :Dispatch! cargo fmt<CR>
map <localleader>cr :Dispatch cargo run<CR>
map <localleader>ct :Dispatch cargo test<CR>
map <localleader>cu :Dispatch cargo update<CR>
map <localleader>cB :Dispatch cargo bench<CR>
" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker :
