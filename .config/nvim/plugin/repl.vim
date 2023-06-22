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
    elseif &filetype == "lua"
        call ReplSend(['lua ' . expand("%")])
    elseif &filetype == "nim"
        call ReplSend(['nim ' . expand("%")])
    elseif &filetype == "haskell"
        call ReplSend([':l ' . expand("%:p:h:t") . '/' . expand("%:p:t")])
    elseif &filetype == "coq"
        call ReplSend(['Require Import ' . expand("%:t:r") ])
    elseif &filetype == "frege"
        call ReplSend([':l ' . expand("%:p:h:t") . '/' . expand("%:p:t")])
    elseif &filetype == "purescript"
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
    elseif &filetype == "bqn"
        call ReplSend(['•Import "' . expand("%") . '"'])
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
        call ReplSend(['(import [' . expand("%:t:r") . '[[*]])'])
    elseif &filetype == "coconut"
        call ReplSend(['from ' . expand("%:t:r") . ' import *'])
    elseif &filetype == "dg"
        call ReplSend(['import /' . expand("%:t:r")])
    elseif &filetype == "python" " || &filetype == "coconut"
        if g:repl_ipython
            call ReplSend(['%load ' . expand("%")])
        else
            call ReplSend(['from ' . expand("%:t:r") . ' import *'])
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
        execute "!mvn -B clean compile exec:java"
    elseif &filetype == "perl"
        execute "!perl ./%"
    elseif &filetype == "lua"
        execute "!lua ./%"
    elseif &filetype == "nim"
        execute "!nim compile --run ./%"
    elseif &filetype == "zig"
        execute "!zig build-exe ./%"
    elseif &filetype == "fortran"
        execute "!gfortran % -o %:r"
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
    elseif &filetype == "gnuplot"
        execute "!gnuplot -persist %"
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
        execute "!stack build && stack exec %:p:h:h:t-exe"
        "execute "!cabal run"
    elseif &filteype == "coq"
        execute "!gmake"
    elseif &filetype == "frege"
        execute "!sbt -no-colors compile && sbt -no-colors run"
    elseif &filetype == "purescript"
        execute "!spago build && spago run"
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
    elseif &filetype == "bqn"
        execute "!bqn -f %"
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
    elseif &filetype == "coconut"
        execute "!coconut-run %"
    elseif &filetype == "dg"
        execute "!python -m dg %"
    elseif &filetype == "python"
        execute "!python %"
    elseif &filetype == "octave" || &filetype == "matlab"
        execute "!term [ $(command -v matlab) ] && matlab -nosplash -nodesktop % || octave --no-gui %"
    elseif &filetype == "spice"
        execute "!ngspice %"
    elseif &filetype == "spectre"
        execute "!spectre %"
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
    elseif &filetype == "lua"
        call OpenREPL("term lua")
        setlocal syntax=lua
    elseif &filetype == "nim"
        call OpenREPL("term nim secret")
        setlocal syntax=nim
    elseif &filetype == "haskell"
        call OpenREPL("term stack ghci")
        "call OpenREPL("term cabal repl")
        setlocal syntax=haskell
    elseif &filetype == "coq"
        call OpenREPL("term rlwrap coqtop")
    elseif &filetype == "frege"
        call OpenREPL("term TERM=xterm-color sbt fregeRepl")
        setlocal syntax=frege
    elseif &filetype == "purescript"
        call OpenREPL("term spago repl")
        setlocal syntax=purescript
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
    elseif &filetype == "bqn"
        call OpenREPL("term bqn")
        setlocal syntax=bqn
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
    elseif &filetype == "spectre"
        call OpenREPL("term rlwrap spectre -64 +interactive %")
        setlocal syntax=spectre
    elseif &filetype == "gnuplot"
        call OpenREPL("term gnuplot")
        setlocal syntax=gnuplot
    elseif &filetype == "hy"
        call OpenREPL("term hy")
        setlocal syntax=hy
    elseif &filetype == "coconut"
        call OpenREPL("term coconut")
        "setlocal syntax=hy
    elseif &filetype == "dg"
        call OpenREPL("term python -m dg")
        setlocal syntax=dg
    elseif &filetype == "python"
        call OpenREPL("term ipython")
        "setlocal syntax=python
    elseif &filetype == "nroff"
        call OpenREPL("term groff -URpetms % -Kutf8 -Tutf8 > %:r.utf8 && less %:r.utf8")
    else
        echo "File Type: " . &filetype . " not supported."
    endif
endfunction
