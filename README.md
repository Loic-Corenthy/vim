# VIM

Some scripts for vim

cplusplus.vim
=============

1. **cplusplus#StartImplemenation**

- **Purpose:**
Copy the signature of a method from the header to the source file, ready to be implemented

- **Known bugs / to do**
  - Doesn't work for a destructor
  - Doesn't find the correct positioning in the cpp file for overloaded methods

- **The mapping that I use in my .vimrc to use the above mentioned function is:**
```
autocmd FileType c,cpp,h,hpp :nnoremap <buffer> <localleader>si :call cplusplus#StartImplementation()<cr>
```
