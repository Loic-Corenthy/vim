# VIM

Some scripts for vim. This code is not supposed to be robust not planned to be maintained in any particular way. Use at your own risks!

autoload/cplusplus.vim
======================

1. **cplusplus#StartImplementation**

- **Purpose:**
Copy the signature of a method from the header to the source file, ready to be implemented

- **Known bugs / to do**
  - Doesn't work for a destructor
  - Doesn't find the correct positioning in the cpp file for overloaded methods

- **The mapping that I use in my .vimrc to use the above mentioned function is:**
```
autocmd FileType c,cpp,h,hpp :nnoremap <buffer> <localleader>si :call cplusplus#StartImplementation()<cr>
```

2. **cplusplus#CallClangFormatCurrentBuffer**

- **Purpose**
Call clang-format for the current buffer and edit the buffer to see the changes

- **The mapping that I use in my .vimrc to use the above mentioned function is:**
```
autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <F5> :call cplusplus#CallClangFormatCurrentBuffer()<cr>
```
