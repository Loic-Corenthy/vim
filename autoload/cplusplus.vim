echom "Loading cplusplus"

function! cplusplus#GetClassName()
   let l:cursorPostion = getcurpos()
   normal gg
   let l:searchResultPos = search('class')
   let l:lineWithClass = getline('.')
   let l:itemsOnTheLine = split(l:lineWithClass)

   " Set back the cursor position
   call setpos('.', l:cursorPostion)

   if l:itemsOnTheLine[0] ==# "class"
       return l:itemsOnTheLine[1]
   else
       return ""
   endif
endfunction


function! cplusplus#StartImplementation()
    " Check that we are running the command in a header file
    let l:fileExtension = expand("%:e")

    if l:fileExtension !=#  "hpp" && l:fileExtension !=# "h"
        echom "This is NOT a header file"
        return
    endif

    " Get the name of the class
    let l:className = cplusplus#GetClassName()

    " Save current cursor position
    let l:cursorPostion = getcurpos()

    " Get the current line (i.e. the method to implement)
    let l:methodToImplement = getline('.')

    " Build the signature of the method to implement
    " 1. Get the name of the method as the sequence of characters preceding (
    " WARNING!!! This doesn't match the name of a destructor since it starts
    " with a ~
    let l:methodName = matchstr(l:methodToImplement, '[_a-zA-Z0-9]\+(')

    " 2. Remove ( from the sequence
    let l:methodName = substitute(l:methodName, "(", "", "")

    " 3. Prepend <classname>:: to the method's name
    let l:methodNameWithClass = l:className . "::" . l:methodName

    let l:methodSignature = substitute(l:methodToImplement, l:methodName, l:methodNameWithClass, "")

    " Remove the \";\" at the end
    let l:methodSignature = substitute(l:methodSignature, ";", "", "")

    " Remove whitespace at the beginning if there is some
    let l:methodSignature = substitute(l:methodSignature, '^\s\+', "", "")

    " Remove = 0 if it is a virtual method
    let l:methodSignature = substitute(l:methodSignature, ')\s\+=\s\+0', ")", "")

    " Remove the keyword virtual if it is a virtual method
    let l:methodSignature = substitute(l:methodSignature, '\s*virtual\s\+', " ", "")

    " Save the current filename
    let l:headerFileName = expand("%:t")

    " Get the name of the file without the extension, change it to
    " <filename>.cpp and switch buffer
    " todo: Check that corresponding cpp file exist
    execute ":buffer " . expand("%:r") . ".cpp"

    " Go to the end of the file a add a line
    execute "normal! Go\<ESC>"

    " Add the method complete signarute
    call append(line('$'), l:methodSignature)

    " Add the curly brakets below
    call append(line('$'), "{")
    execute "normal! o\<ESC>"
    call append(line('$'), "}")

    " Go back to the header file
    execute  ":buffer " . l:headerFileName

    " Set back the cursor position
    call setpos('.', l:cursorPostion)
endfunction


