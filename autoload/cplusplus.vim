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


function! cplusplus#GenerateMethodSignature(headerMethod, className)
    " Build the signature of the method to implement
    " 1. Get the name of the method as the sequence of characters preceding (
    " WARNING!!! This doesn't match the name of a destructor since it starts
    " with a ~
    let l:methodName = matchstr(a:headerMethod, '[_a-zA-Z0-9]\+(')

    " 2. Remove ( from the sequence
    let l:methodName = substitute(l:methodName, "(", "", "")

    " 3. Prepend <classname>:: to the method's name
    let l:methodNameWithClass = a:className . "::" . l:methodName

    let l:methodSignature = substitute(a:headerMethod, l:methodName, l:methodNameWithClass, "")

    " Remove the \";\" at the end
    let l:methodSignature = substitute(l:methodSignature, ";", "", "")

    " Remove whitespace at the beginning if there is some
    let l:methodSignature = substitute(l:methodSignature, '^\s\+', "", "")

    " Remove = 0 if it is a virtual method
    let l:methodSignature = substitute(l:methodSignature, ')\s\+=\s\+0', ")", "")

    " Remove the keyword virtual if it is a virtual method
    let l:methodSignature = substitute(l:methodSignature, 'virtual\s\+', " ", "")

    return l:methodSignature
endfunction


function! cplusplus#FindAboveMethod(cursorPosition)
    call setpos('.', a:cursorPosition)

    " Go to the above line
    execute "normal! k"

    " Search for the next method, just above the current one (search
    " backwards)
    let l:previousMethodNamePosition = search('[_a-zA-Z0-9]\+(', 'b')

    " If the index of the line containing the previous method is bigger than
    " the current line, it means we didn't find any method before the current
    " one 
    if l:previousMethodNamePosition > a:cursorPosition[1]
        return ""
    else
        let l:previousMethodName = getline(l:previousMethodNamePosition)
        let l:previousMethodName = matchstr(l:previousMethodName, '[_a-zA-Z0-9]\+(')
        return l:previousMethodName
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
    let l:cursorPosition = getcurpos()

    " Get the current line (i.e. the method to implement)
    let l:methodToImplement = getline('.')

    " Generate the correct method signature that can be pasted in the cpp file
    let l:methodSignature = cplusplus#GenerateMethodSignature(l:methodToImplement, l:className)

    " Get the current filename
    let l:headerFileName = expand("%:t")

    " Find the name of the method above the one we want to implement
    let l:aboveMethod = cplusplus#FindAboveMethod(l:cursorPosition)

    " Get the name of the file without the extension, change it to
    " <filename>.cpp and switch buffer
    " todo: Check that corresponding cpp file exist
    execute ":buffer " . expand("%:r") . ".cpp"

    " If we didn't find a method above the current one, add the implementation
    " at the bottom of the cpp file
    if len(l:aboveMethod) == 0
        " Go to the end of the file a add a line
        execute "normal! Go\<ESC>"

        " Add the method complete signature
        call append(line('$'), l:methodSignature)

        " Add the curly brackets below
        call append(line('$'), "{")
        execute "normal! o\<ESC>"
        call append(line('$'), "}")
    else
    " Otherwise, add the method in the same order as in the hpp file
        " Go to the end of the file and search backwards for the name of the
        " method above the one to implement
        execute "normal! G"
        let l:position = search(l:aboveMethod, 'b')

        " Search for the next opening curly bracket as the start of the
        " implementation of the above method
        let l:braketPosition = search("{")

        " Go to the corresponding closing bracket as the end of the
        " implementation of the above method
        execute "normal! %"

        " Add a blanc line
        execute "normal! o\<ESC>"

        " Set the cursor to this current position
        let l:correctCursorPosition = getcurpos()
        call setpos('.',l:correctCursorPosition)

        " Add the method complete signature
        call append(l:correctCursorPosition[1], l:methodSignature)

        " Add the curly brackets below
        call append(l:correctCursorPosition[1]+1, "{")
        execute "normal! o\<ESC>"
        call append(l:correctCursorPosition[1]+3, "}")
    endif

    " Go back to the header file
    execute  ":buffer " . l:headerFileName

    " Set back the cursor position
    call setpos('.', l:cursorPosition)
endfunction
