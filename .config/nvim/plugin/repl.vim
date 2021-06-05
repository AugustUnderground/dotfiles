" Because IPython REPL needs special treatment for pasting
let g:repl_ipython = 0
let g:repl_ghci = 0

" groff/troff/nroff/roff target
let g:roff_target = 'pdf'
let g:roff_image = 0

" Make sure Job ID is stored
augroup Terminal
    au!
    au TermOpen * let g:repl_job_id = b:terminal_job_id
augroup END

" Send Lines from code to terminal
function! ReplSend(lines)
    call jobsend(g:repl_job_id, add(a:lines, ''))
endfunction

function! ReplSelectRegion(linenr)
    normal! mz
    norm {
    let startline = nextnonblank(getcurpos()[1])
    norm }
    let endline = prevnonblank(getcurpos()[1])

    if startline == endline
        let lines = [getline(startline)]
    else
        let lines = getline(startline, endline)
    endif
    if g:repl_ipython
        "silent exe startline . ',' . endline . 'yank'
        let pasteblock = []
        for line in lines
            let line = substitute(line, '\', '\\\\\\\', "g")
            let line = substitute(line, '#', '\\#', "g")
            let line = substitute(line, '"', '\\"', "g")
            let pasteblock = add(pasteblock, line)
        endfor
        let lines = join(pasteblock, '\n')
        silent exe '!printf "' . lines . '" | xsel -ib'
        return ["%paste"]
    elseif g:repl_ghci
        let lines = [":{"] + lines + [":}"]
        return lines
    else
        return lines
    endif
    normal! `z
endfunction

" Reload file in REPL
function! ReplReload()
    if &filetype == "sh"
        call ReplSend(['source ' . expand("%")])
    elseif &filetype == "perl"
        call ReplSend(['perl ' . expand("%")])
    elseif &filetype == "haskell"
        call ReplSend([':l ' . expand("%:p:h:t") . '/' . expand("%:p:t")])
    elseif &filetype == "ocaml"
        call ReplSend(['#use ' . '"' . expand("%:t") . '";;'])
    elseif &filetype == "elm"
        call ReplSend(['import ' . expand("%:t:r")])
    elseif &filetype == "javascript"
        call ReplSend(['require(''' . expand("%") . ''');'])
        " call ReplSend(['.load ' . expand("%")])
    elseif &filetype == "ruby"
        call ReplSend(['require ''' . './' . expand("%") . ''''])
    elseif &filetype == "scheme"
        call ReplSend(['(load "' . expand("%") . '")'])
    elseif &filetype == "racket"
        call ReplSend(['(load "' . expand("%") . '")'])
    elseif &filetype == "r" || &filetype == "rmd"
        call ReplSend(['source("' . expand("%:t") . '")'])
    elseif &filetype == "julia"
        call ReplSend(['include("' . expand("%:t") . '")'])
    elseif &filetype == "clojure"
        call ReplSend(['(use '''. expand("%:r:gs?/?.?") . ' :reload-all)'])
    elseif &filetype == "octave" || &filetype == "matlab"
        call ReplSend(['run ' . expand("%:t:r")])
    elseif &filetype == "spice"
        call ReplSend([expand("%")])
    elseif &filetype == "hy"
        call ReplSend(['(import ' . expand("%:t:r") . ')'])
    elseif &filetype == "python"
        if g:repl_ipython
            call ReplSend(['%load ' . expand("%")])
        else
            call ReplSend(['import ' . expand("%:t:r")])
        endif
    elseif &filetype == "nroff"
        execute "!groff -URpetms % -Kutf8 -Tutf8 > %:r.utf8"
        cal ReplSend(['R'])
    else
        echo "File Type: " . &filetype . " not supported."
    endif
endfunction

command! ReplSendLine call ReplSend([getline('.')])
command! ReplSendRegion call ReplSend(ReplSelectRegion(line('.')))
command! ReplReloadFile call ReplReload()

" Compile and Run current file
function CompileRun()
    if &filetype == "sh"
        execute "!sh %"
    elseif &filetype == "java"
        execute "!javac %"
        execute "!java -cp ./ %:r"
    elseif &filetype == "perl"
        execute "!perl ./%"
    elseif &filetype == "c"
        execute "!gcc -o %:r.out %"
        execute "!chmod a+x %:r.out"
        execute "!./%:r.out"
    elseif &filetype == "nroff"
        if g:roff_image
            execute "!groff -URpetms % -Kutf8 | ps2pdf - %:r.pdf"
        else
            execute "!groff -URpetms % -Kutf8 -Tpdf > %:r.pdf"
        endif
    elseif &filetype == "tex"
        execute "!pdflatex --shell-escape %"
    elseif &filetype == "markdown"
        execute "!pandoc -f markdown-implicit_figures --citeproc % --from=markdown --to=latex --output=%:r.pdf"
        "execute "!pandoc -f markdown-implicit_figures --citeproc % --pdf-engine=xelatex -so %:r.pdf"
        "execute "!pandoc -F pandoc-crossref --citeproc % -so %:r.pdf"
    elseif &filetype == "pandoc"
        execute "!pandoc % -s -o %:r.pdf"
    elseif &filetype == "bib"
        execute "!bibtex %:r"
    elseif &filetype == "haskell"
        execute "!stack build && stack exec %:p:h:h:t"
        "execute "!cabal run"
    elseif &filetype == "ocaml"
        execute "!dune build && dune exec ./%:t:r.exe"
    elseif &filetype == "elm"
        execute "!elm make % --output=%:t:r.js"
    elseif &filetype == "ruby"
        execute "!ruby %"
    elseif &filetype == "scheme"
        execute "!guile -f %"
    elseif &filetype == "racket"
        execute "!racket %"
    elseif &filetype == "r"
        execute "!R --no-save < %"
    elseif &filetype == "rust"
        execute "!cargo build && cargo run"
    elseif &filetype == "go"
        execute "!go build -o %:r"
    elseif &filetype == "rmd"
        execute "!Rscript -e \"rmarkdown::render(\\\"%\\\", clean=TRUE)\""
    elseif &filetype == "julia"
        execute "!julia %"
    elseif &filetype == "clojure"
        execute "!lein run"
    elseif &filetype == "hy"
        execute "!hy %"
    elseif &filetype == "python"
        execute "!python %"
    elseif &filetype == "octave" || &filetype == "matlab"
        execute "!term [ $(command -v matlab) ] && matlab -nosplash -nodesktop % || octave --no-gui %"
    elseif &filetype == "spice"
        execute "!ngspice %"
    else
        echo "File Type: " . &filetype . " not supported."
    endif
endfunction

" Start REPL and Load
function OpenREPL(cmd)
    execute "belowright vsplit"
    execute "vertical resize -15"
    execute a:cmd
    setlocal modifiable
    setlocal nonumber
    setlocal norelativenumber
    setlocal signcolumn=no
    setlocal nocursorline
    setlocal nocursorcolumn
    setlocal syntax
    normal A
endfunction

function InteractiveLoad()
    if &filetype == "sh"
        call OpenREPL("term rlwrap sh")
        setlocal syntax=sh
    elseif &filetype == "perl"
        call OpenREPL("term rlwrap sh")
        setlocal syntax=perl
    elseif &filetype == "haskell"
        call OpenREPL("term stack ghci")
        "call OpenREPL("term cabal repl")
        setlocal syntax=haskell
    elseif &filetype == "ocaml"
        call OpenREPL("term utop")
    elseif &filetype == "elm"
        call OpenREPL("term elm repl")
        setlocal syntax=elm
    elseif &filetype == "javascript"
        call OpenREPL("term node")
        setlocal syntax=javascript
    elseif &filetype == "ruby"
        call OpenREPL("term irb")
        setlocal syntax=ruby
    elseif &filetype == "scheme"
        call OpenREPL("term rlwrap guile")
        setlocal syntax=scheme
    elseif &filetype == "racket"
        call OpenREPL("term racket")
        setlocal syntax=racket
    elseif &filetype == "r" || &filetype == "rmd"
        call OpenREPL("term R")
        setlocal syntax=r
    elseif &filetype == "julia"
        call OpenREPL("term julia --project")
    elseif &filetype == "clojure"
        call OpenREPL("term lein repl")
        setlocal syntax=clojure
    elseif &filetype == "octave" || &filetype == "matlab"
        call OpenREPL("term [ $(command -v matlab) ] && matlab -nosplash -nodesktop || octave --no-gui")
        setlocal syntax=matlab
    elseif &filetype == "mma"
        call OpenREPL("term mathicsscript --unicode --completion")
    elseif &filetype == "spice"
        call OpenREPL("term ngspice")
        setlocal syntax=spice
    elseif &filetype == "hy"
        call OpenREPL("term hy")
        setlocal syntax=hy
    elseif &filetype == "python"
        call OpenREPL("term ipython")
        "setlocal syntax=python
    elseif &filetype == "nroff"
        call OpenREPL("term groff -URpetms % -Kutf8 -Tutf8 > %:r.utf8 && less %:r.utf8")
    else
        echo "File Type: " . &filetype . " not supported."
    endif
endfunction
