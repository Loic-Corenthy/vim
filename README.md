# VIM

Some scripts for vim

cplusplus.vim
=============

cplusplus#StartImplemenation
----------------------------

- Purpose:
Copy the signature of a method from the header to the source file, ready
to be implemented

- The mapping that I use in my .vimrc to use the above mentioned function is:
autocmd FileType c,cpp,h,hpp :nnoremap <buffer> <localleader>si :call cplusplus#StartImplementation()<cr>
