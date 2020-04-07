" Disable compatibility mode
set nocompatible

" Enable 256 color support
if $TERM == "xterm-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

" Use Vundle if it's available
" Setup Vundle plugin manager
filetype off

" Add my own c++ plugin
set runtimepath+=~/.vim/bundle/cplusplus.vim

set runtimepath+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
" Installs plugin manager
Plugin 'VundleVim/Vundle.vim'
" Installs you complete me
Plugin 'Valloric/YouCompleteMe'
" Installs fugitive to use git within vim
Plugin 'tpope/vim-fugitive'
" Installs omnisharp for C# IDE features within vim
Plugin 'OmniSharp/omnisharp-vim'
" Installs fugitive to use git within vim
Plugin 'tpope/vim-dispatch'
" Installs fugitive to use git within vim
Plugin 'lervag/vimtex'
" Installs ultisnips for snippets
Plugin 'SirVer/ultisnips'
" Install vim-snippets to actually get vim snippets
Plugin 'honza/vim-snippets'
" Install taglist.vim to see code information
Plugin 'taglist.vim'
" Install vim-doxygentoolkit to handle doxygen
Plugin 'vim-scripts/DoxygenToolkit.vim'
call vundle#end()


" Enable filetype plugins, indenting and syntax highlightin
filetype plugin indent on
syntax enable

" Enable per-project .vimrc files.
set exrc
set secure

" Disable bells
set noerrorbells visualbell t_vb=

" General editor options {{{
set number          " Enable line numbering
" set cursorline    " Highlight the current line
set nowrap          " Disable line wrapping
set textwidth=0     " Disable line wrapping
set wrapmargin=0    " Disable line wrapping
set hidden

" Allow deleting past end of line, start of insert and indents.
set backspace=indent,eol,start

" Tabs and indenting
set tabstop=4       " Indent in multiples of 2
set shiftwidth=4    " Indent in multiples of 2
set expandtab       " Use spaces not tab
" set noexpandtab       " Use tabs, not spaces

" Formatting options
set smartindent     " Enable smart indenting
set autoindent      " Enable auto indenting

" Search options
set ignorecase      " Ignore case...
set smartcase       " ...unless capital letters are used
set incsearch       " Match while typing search
set hlsearch        " Highlight the searched term

" Configure status line
set statusline=%f         " Path to the file
set statusline+=\ -\ %p%% " Percentage in the file
set statusline+=%=        " Switch to the right side
set statusline+=%04l      " Current line
set statusline+=/         " Separator
set statusline+=%04L      " Total linest
set laststatus=2          " Mention that the status line is always visible

" set rtp+={repository_root}/powerline/bindings/vim
" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup



" Enable mouse support
set mouse=a

" Encryption method
set cm=blowfish2

set matchtime=5
" }}}

" Enable Unite searching
"nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
"if executable('pt')
"  let g:unite_source_grep_command = 'pt'
"  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
"  let g:unite_source_grep_recursive_opt = ''
"  let g:unite_source_grep_encoding = 'utf-8'
"endif

" Restore to last position in a file and remember open buffers
"autocmd BufReadPost *
"  \ if line("'\"") > 0 && line("'\"") <= line("$") |
"  \   exe "normal! g`\"" |
"  \ endif
"set viminfo^=%

" Smart buffer switching
try
  set switchbuf=useopen,usetab,newtab
  set showtabline=1
catch
endtry

" Set leader and local leader
let mapleader = ","
let maplocalleader = ","
let g:C_MapLeader = ","


" Use kj instead of escape to swich back to command mode
inoremap kj <ESC>

" use ctrl-u to make the current word uppercase
inoremap <Leader>u <esc>viwUea
nnoremap <Leader>u viwU

" Center the view with space key
nnoremap <SPACE> zz

" Center the view when searching for next or previous word
nnoremap n nzz
nnoremap N Nzz

" move lines
nnoremap - ddp
nnoremap _ dd2kp

" open .vimrc
nnoremap <Leader>ev :split $MYVIMRC<cr>

" source .vimrv
nnoremap <Leader>sv :source $MYVIMRC<cr>

" Copy all to clipboard
nnoremap <Leader>sa ggVG"+y

" Move at the beginning and the end of a line
nnoremap H 0
nnoremap L $be

" Use arrow keys to navigate between tabs
nnoremap <silent> <A-Up> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR> 
nnoremap <silent> <A-Down> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Use only left and right arrow to navigate between buffers in normal mode
nnoremap <up> <nop>
nnoremap <Left> :bp<CR>
nnoremap <right> :bn<CR>
nnoremap <down> <nop>

" Deactivate navigation with arrow keys in edit mode
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Shortcuts for git within vim {{{
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit -v<CR>
nnoremap <silent> <leader>ga :Gwrite<cr>
nnoremap <silent> <leader>gb :Gblame<cr>
" }}}


" Operator-pending mapping {{{
" Apply to content inside next parenthesis
onoremap in( :<c-u>normal! f(vi(<cr>
" Apply to content inside previous (last) parenthesis
onoremap il( :<c-u>normal! F)vi(<cr>
" Apply to \"name\" of a function, i.e. name before parenthesis
onoremap <silent> F :<C-U>normal! 0f(hviw<CR>
" }}}


" Abbreviation for my signature
iabbrev ssig --<cr>Loïc Corenthy


" Syntax to fold in vim settings {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}


" Highlight trailing whitespaces as errors
match Error /\v\s+$/


" Mappings for tex files {{{
augroup filetype_tex
 	autocmd!
" 	" Abbreviations for sensations latex file
" 	autocmd FileType *tex :iabbrev uhsensation \sensation{NAME}<cr>{DESCRIPTION\_FEEDBACK}<cr>{USE\_CASE}<cr>{IMPLEMENTATION\_AM}<cr>{IMPLEMENTATION\_TS}<cr>{LANGUAGE}<cr>{CLASS}<cr>
" 	autocmd FileType *tex :iabbrev uhgesture \gesture{NAME}<cr>{DESCRIPTION}<cr>{SYSTEM}<cr>{RELIABILITY}<cr>
" 	" Comment a line
 	autocmd FileType tex :nnoremap <buffer> <localleader>cc I%<space><esc>
    " Comment the current line and duplicate it just below
    autocmd FileType tex :nnoremap <buffer> <localleader>cv yypk0wi% <esc>j0w
" 	" Latex style quotes around selected region
" 	autocmd FileType *tex :vnoremap <buffer> <localleader>' xi``<esc>pa''<esc>a
    " Latex style quotes around current word in normal mode
    autocmd FileType tex :nnoremap <buffer> <Leader>' viw<esc>a''<esc>hbi``<esc>lel
    autocmd FileType tex :vnoremap <buffer> <Leader>' c``''<esc>hhp
    " Make highlighted text bold
    autocmd FileType tex :vnoremap <buffer> <Leader>bf di\textbf{}<esc>hpll
 augroup END
" }}}


" Mappings for C# files {{{
augroup filetype_cs
	autocmd!
	autocmd FileType cs :nnoremap  <localleader>cc I//<space><esc>
	autocmd FileType cs :nnoremap  <localleader>co 03x
augroup END
" }}}


" Mappings for python files {{{
augroup filetype_py
	autocmd!
    autocmd BufNewFile :echo "This is a python file"
    " Comment the current line
	autocmd FileType python :nnoremap <buffer> <localleader>cc I#<space><esc>
    " Comment the current line and duplicate it just below
    autocmd FileType python :nnoremap <buffer> <localleader>cv yypk0wi# <esc>j0w
	autocmd FileType python :iabbrev iff if:<left>
augroup END
" }}}


" Mappings for html files {{{
augroup filetype_html
    autocmd!
    " ??
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END
" }}}


" Mappings for mark-down {{{
augroup filetype_md
	autocmd!
    " Comment the current line
 	autocmd FileType markdown :nnoremap <buffer> <localleader>cc I#<space><esc>
    " Change/delete/copy the title of the current paragraph
	autocmd FileType markdown :onoremap ih :<c-u>execute "normal! ?^[==\|--]\\+$\r:nohlsearch\rkvg_"<cr>
    " Change/delete/copy the title of the last paragraph
	autocmd FileType markdown :onoremap ah :<c-u>execute "normal! ?^[==\|--]\\+$\r:nohlsearch\rg_vk0"<cr>
    " Add a line of = under a title. Cursor must be on the line in normal mode
    autocmd FileType markdown :nnoremap <buffer> <localleader>tu 0v$yo<esc>pv$r=<esc>o<cr>
augroup END
" }}}


" Mappings for c++ {{{
augroup filetype_cpp
    autocmd!
	autocmd BufNewFile,BufRead h,c,hpp,cpp :set nospell
    autocmd BufWritePre h,c,hpp,cpp :%s/\s\+$//e
    " comment current line
 	autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <localleader>cc I//<space><esc>
 	autocmd FileType h,c,hpp,cpp :vnoremap <buffer> <localleader>cc <esc>:'<,'>s/\(.\)/\/\/ \1/<cr> :nohlsearch<cr>
    " uncomment current line
 	autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <localleader>co 0wxxx
    " comment current and paste same text below
    autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <localleader>cv yypk0wi// <esc>j0w
    " Switch between files with the shortcuts used to switch between header and
    " source file in Xcode
    " nnoremap <C-S-Up> :n
    " nnoremap <C-S-Down> :prev
    autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <C-S-Up> :e #<cr>
    autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <C-S-Down> :e #<cr>
    " Open the cpp related to the current hpp file
    autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <localleader>oc :split %:r.cpp<cr>
    " Open the hpp related to the current cpp file
    autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <localleader>oh :split %:r.hpp<cr>
    " Copy the signature of a method from the header to the source file, ready
    " to be implemented
    autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <localleader>si :call cplusplus#StartImplementation()<cr>
    " Remove all the std:: on the current line
    autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <localleader>rs :.s/std:://g<cr> :nohlsearch<cr>
    autocmd FileType h,c,hpp,cpp :vnoremap <buffer> <localleader>rs <esc>:'<,'>s/std:://g<cr> :nohlsearch<cr>
    " Go to declaration / definition
    autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <F2> :YcmCompleter GoTo<cr>
    autocmd FileType h,c,hpp,cpp :vnoremap <buffer> <F2> :YcmCompleter GoTo<cr>
    " Show the type of a variable
    autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <F3> :YcmCompleter GetType<cr>
    " Call Fix It
    autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <F4> :YcmCompleter FixIt<cr>
    " Formatting with clang-format
    autocmd FileType h,c,hpp,cpp :nnoremap <buffer> <F5> :call cplusplus#CallClangFormatCurrentBuffer()<cr>
augroup END
" }}}


" Mappings for cmake {{{
augroup filetype_cmake
    autocmd!
	autocmd BufNewFile,BufRead cmake :set nospell
    autocmd BufWritePre cmake :%s/\s\+$//e
    " Formatting with clang-format
    autocmd FileType cmake :nnoremap <buffer> <F5> :call system('cmake-format -i ' . shellescape(expand('%:p')))<cr>:e!<cr>
augroup END
" }}}


" filetype plugin on 

" Set the max number of tabs that can be opened at the same time 
set tabpagemax=20

" use make to compile and link
let g:Make_Executable = 'make'


" You Complete Me settings {{{
" let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

autocmd BufReadPost fugitive://* set bufhidden=delete
" Set template version for cvim to avoid warning message each time we use vim
" let g:Templates_Version = '6.1.1'

if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

" Go to with YCM
"nnoremap <leader>jd :YcmCompleter GoTo<CR>

" load ycm conf by default
let g:ycm_confirm_extra_conf=0
" }}}


" Ultisnip settings {{{
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif
  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
	" let g:UltiSnipsJumpForwardTrigger = "<tab>"
	let g:UltiSnipsJumpForwardTrigger = "<c-j>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  " let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
" }}}


" Configuration for taglist plugin {{{
let Tlist_Ctags_Cmd = '/bin/ctags'
" }}}


" Spell checking settings {{{
set spell spelllang=en_gb
" - To turn spell checking on: 'setlocal spell spelllang=en_us'
" - To move to a misspelled word: ']s' and '[s'
" - To show spelling suggestions on a highlighted word: 'z='
" - To add a word to the dictionary: 'zg'
" }}}
