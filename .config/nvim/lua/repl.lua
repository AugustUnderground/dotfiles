local M = {}
local vim = vim

local roff_target  = "pdf"
local roff_image   = false
local ipython_repl = false
local ghci_repl    = false
local repl_job_id  = 0

local function terminal_job_id()
  return vim.bo[vim.api.nvim_get_current_buf()].channel
end

local function send_to_repl(lines)
  vim.api.nvim_chan_send(repl_job_id, lines)
end

local function select_region()
  local lines = {}
  vim.cmd.normal("mz")
  vim.cmd.normal("{")
  local start_line = vim.fn.nextnonblank(vim.api.nvim_win_get_cursor(0)[1])
  vim.cmd.normal("}")
  local end_line   = vim.fn.prevnonblank(vim.api.nvim_win_get_cursor(0)[1])
  lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, true)
  vim.cmd.normal("`z")
  return lines
end

local function start_repl(cmd)
  local terminal = vim.api.nvim_create_augroup("Terminal", { clear = true })
  vim.api.nvim_create_autocmd( "TermOpen"
                             , { desc     = "Store Job ID of Terminal"
                               , group    = terminal
                               , pattern  = "*"
                               , callback = function()
                                      repl_job_id = terminal_job_id()
                                    end
                               , } )

  vim.cmd("belowright vsplit")
  vim.cmd("vertical resize -15")
  vim.cmd(cmd)
  vim.opt_local.modifiable     = true
  vim.opt_local.number         = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn     = "no"
  vim.opt_local.cursorline     = false
  vim.opt_local.cursorcolumn   = false
  vim.cmd.normal("A")
end

function M.repl_send_line()
  local line  = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
  send_to_repl(lines .. "\n")
end

function M.repl_send_region()
  local lines = select_region()
  if ipython_repl then
    for _,line in ipairs(lines) do
      send_to_repl((line:gsub("^%s*(.-)%s*$", "%1")) .. "\n")
    end
    send_to_repl("\n")
  elseif ghci_repl then
    send_to_repl(":{\n" .. table.concat(lines, "\n") .. "\n:}\n")
  else
    send_to_repl(table.concat(lines, "\n") .. "\n")
  end
end

function M.repl_reload_file()
  local filetype = vim.bo.filetype

  if filetype == "sh" then
    send_to_repl("source " .. vim.fn.expand("%"))
  elseif filetype == "perl" then
    send_to_repl("perl " .. vim.fn.expand("%"))
  elseif filetype == "lua" then
    send_to_repl("lua " .. vim.fn.expand("%"))
  elseif filetype == "nim" then
    send_to_repl("nim " .. vim.fn.expand("%"))
  elseif filetype == "haskell" then
    send_to_repl(":l " .. vim.fn.expand("%:p:h:t") .. "/" .. vim.fn.expand("%:p:t"))
  elseif filetype == "idris2" then
    send_to_repl(":l \"" .. vim.fn.expand("%r") .. "\"")
  elseif filetype == "coq" then
    send_to_repl("Require Import " .. vim.fn.expand("%:t:r") )
  elseif filetype == "frege" then
    send_to_repl(":l " .. vim.fn.expand("%:p:h:t") .. "/" .. vim.fn.expand("%:p:t"))
  elseif filetype == "purescript" then
    send_to_repl(":l " .. vim.fn.expand("%:p:h:t") .. "/" .. vim.fn.expand("%:p:t"))
  elseif filetype == "ocaml" then
    send_to_repl("#use " .. "\"" .. vim.fn.expand("%:t") .. "\";;")
  elseif filetype == "elm" then
    send_to_repl("import " .. vim.fn.expand("%:t:r"))
  elseif filetype == "javascript" then
    send_to_repl("require('" .. vim.fn.expand("%") .. "');")
  elseif filetype == "ruby" then
    send_to_repl("require '" .. "./" .. vim.fn.expand("%") .. "'")
  elseif filetype == "scheme" then
    send_to_repl("(load \"" .. vim.fn.expand("%") .. "\")")
  elseif filetype == "racket" then
    send_to_repl("(load \"" .. vim.fn.expand("%") .. "\")")
  elseif filetype == "bqn" then
    send_to_repl("•Import \"" .. vim.fn.expand("%") .. "\"")
  elseif (filetype == "r" or filetype == "rmd") then
    send_to_repl("source(\"" .. vim.fn.expand("%:t") .. "\")")
  elseif filetype == "julia" then
    send_to_repl("include(\"" .. vim.fn.expand("%:t") .. "\")")
  elseif filetype == "clojure" then
    send_to_repl("(use '" .. vim.fn.expand("%:r:gs?/?.?") .. " :reload-all)")
  elseif (filetype == "octave" or filetype == "matlab") then
    send_to_repl("run " .. vim.fn.expand("%:t:r"))
  elseif filetype == "spice" then
    send_to_repl(vim.fn.expand("%"))
  elseif filetype == "hy" then
    send_to_repl("(import " .. vim.fn.expand("%:t:r") .. "[*])")
  elseif filetype == "coconut" then
    send_to_repl("from " .. vim.fn.expand("%:t:r") .. " import *")
  elseif filetype == "dg" then
    send_to_repl("import /" .. vim.fn.expand("%:t:r"))
  elseif filetype == "python" then
    if repl_ipython then
      send_to_repl("%load " .. vim.fn.expand("%"))
    else
      send_to_repl("from " .. vim.fn.expand("%:t:r") .. " import *")
    end
  elseif filetype == "nroff" then
    vim.cmd("!groff -URpetms % -Kutf8 -Tutf8 > %:r.utf8")
    send_to_repl("R")
  else
    vim.api.nvim_err_writeln("Filetype " .. filetype .. " not supported.")
  end
end

function M.compile_and_run()
  local filetype = vim.bo.filetype

  if filetype == "sh" then
    vim.cmd("!sh %")
  elseif filetype == "java" then
    vim.cmd("!mvn -B clean compile exec:java")
  elseif filetype == "perl" then
    vim.cmd("!perl ./%")
  elseif filetype == "lua" then
    vim.cmd("!lua ./%")
  elseif filetype == "nim" then
    vim.cmd("!nim compile --run ./%")
  elseif filetype == "zig" then
    vim.cmd("!zig build-exe ./%")
  elseif filetype == "fortran" then
    vim.cmd("!fpm run")
    --vim.cmd("!gfortran % -o %:r && ./%:r")
  elseif filetype == "c" then
    vim.cmd("!gcc -o %:r.out %")
    vim.cmd("!chmod a+x %:r.out")
    vim.cmd("!./%:r.out")
  elseif filetype == "nroff" then
      if roff_image then
          vim.cmd("!groff -URpetms % -Kutf8 | ps2pdf - %:r.pdf")
      else
          vim.cmd("!groff -URpetms % -Kutf8 -Tpdf > %:r.pdf")
      end
  elseif filetype == "gnuplot" then
    vim.cmd("!gnuplot -persist %")
  elseif filetype == "tex" then
    vim.cmd("!lualatex -enable-write18 -shell-escape %")
  elseif filetype == "markdown" then
    vim.cmd("!pandoc -f markdown-implicit_figures --citeproc % --from=markdown --to=latex --output=%:r.pdf")
  elseif filetype == "pandoc" then
    vim.cmd("!pandoc % -s -o %:r.pdf")
  elseif filetype == "bib" then
    vim.cmd("!biber %:r")
  elseif filetype == "haskell" then
    vim.cmd("!stack build && stack exec %:p:h:h:t-exe")
  elseif filetype == "agda" then
    vim.cmd("!agda --compile % && ./%:r")
  elseif filetype == "idris2" then
    vim.cmd("!pack build && pack run")
  elseif filetype == "coq" then
    vim.cmd("!gmake")
  elseif filetype == "frege" then
    vim.cmd("!sbt -no-colors compile && sbt -no-colors run")
  elseif filetype == "purescript" then
    vim.cmd("!spago build && spago run")
  elseif filetype == "ocaml" then
    vim.cmd("!dune build && dune exec $(basename `pwd`)")
  elseif filetype == "elm" then
    vim.cmd("!elm make % --output=%:t:r.js")
  elseif filetype == "ruby" then
    vim.cmd(vim.cmd("!ruby %"))
  elseif filetype == "scheme" then
    vim.cmd("!guile -f %")
  elseif filetype == "racket" then
    vim.cmd("!racket %")
  elseif filetype == "bqn" then
    vim.cmd("!bqn -f %")
  elseif filetype == "r" then
    vim.cmd("!R --no-save < %")
  elseif filetype == "rust" then
    vim.cmd("!cargo build && cargo run")
  elseif filetype == "go" then
    vim.cmd("!go build -o %:r")
  elseif filetype == "rmd" then
    vim.cmd("!Rscript -e \"rmarkdown::render(\\\"%\\\", clean=TRUE)\"")
  elseif filetype == "julia" then
    vim.cmd("!julia %")
  elseif filetype == "clojure" then
    vim.cmd("!lein run")
  elseif filetype == "hy" then
    vim.cmd("!hy %")
  elseif filetype == "coconut" then
    vim.cmd("!coconut-run %")
  elseif filetype == "dg" then
    vim.cmd("!python -m dg %")
  elseif filetype == "python" then
    vim.cmd("!python %")
  elseif filetype == "bend" then
    vim.cmd("!bend run-cu %")
  elseif (filetype == "octave" or filetype == "matlab") then
    vim.cmd("!term [ $(command -v matlab) ] && matlab -nosplash -nodesktop % || octave --no-gui %")
  elseif filetype == "spice" then
    vim.cmd("!ngspice %")
  elseif filetype == "spectre" then
    vim.cmd("!spectre %")
  elseif filetype == "swift" then
    vim.cmd("XcodebuildBuildRun")
  else
    vim.api.nvim_err_writeln("Filetype " .. filetype .. " not supported.")
  end
end

function M.start_repl()
  local filetype = vim.bo.filetype

  if filetype == "sh" then
    start_repl("term rlwrap sh")
    vim.opt_local.syntax = "sh"
  elseif filetype == "perl" then
    start_repl("term rlwrap sh")
    vim.opt_local.syntax = "perl"
  elseif filetype == "lua" then
    start_repl("term lua")
    vim.opt_local.syntax = "lua"
  elseif filetype == "nim" then
    start_repl("term nim secret")
    vim.opt_local.syntax = "nim"
  elseif filetype == "haskell" then
    ghci_repl = true
    start_repl("term stack ghci")
    vim.opt_local.syntax = "haskell"
  elseif filetype == "agda" then
    start_repl("term agda -I")
    vim.opt_local.syntax = "agda"
  elseif filetype == "idris2" then
    start_repl("term rlwrap pack repl")
    vim.opt_local.syntax = "idris2"
  elseif filetype == "coq" then
    start_repl("term rlwrap coqtop")
  elseif filetype == "frege" then
    start_repl("term TERM=xterm-color sbt fregeRepl")
    vim.opt_local.syntax = "frege"
  elseif filetype == "purescript" then
    start_repl("term spago repl") vim.opt_local.syntax = "purescript"
  elseif filetype == "ocaml" then
    start_repl("term dune utop")
  elseif filetype == "elm" then
    start_repl("term elm repl")
    vim.opt_local.syntax = "elm"
  elseif filetype == "javascript" then
    start_repl("term node")
    vim.opt_local.syntax = "javascript"
  elseif filetype == "ruby" then
    start_repl("term irb")
    vim.opt_local.syntax = "ruby"
  elseif filetype == "scheme" then
    start_repl("term rlwrap guile")
    vim.opt_local.syntax = "scheme"
  elseif filetype == "racket" then
    start_repl("term racket")
    vim.opt_local.syntax = "racket"
  elseif filetype == "bqn" then
    start_repl("term bqn")
    vim.opt_local.syntax = "bqn"
  elseif (filetype == "r" or filetype == "rmd") then
    start_repl("term R")
    vim.opt_local.syntax = "r"
  elseif filetype == "julia" then
    start_repl("term julia --project=.")
  elseif filetype == "clojure" then
    start_repl("term lein repl")
    vim.opt_local.syntax = "clojure"
  elseif (filetype == "octave" or filetype == "matlab") then
    start_repl("term [ $(command -v matlab) ] && matlab -nosplash -nodesktop || octave --no-gui")
    vim.opt_local.syntax = "matlab"
  elseif filetype == "mma" then
    start_repl("term mathicsscript --unicode --completion")
  elseif filetype == "spice" then
    start_repl("term ngspice")
    vim.opt_local.syntax = "spice"
  elseif filetype == "spectre" then
    start_repl("term rlwrap spectre -64 +interactive %")
    vim.opt_local.syntax = "spectre"
  elseif filetype == "gnuplot" then
    start_repl("term gnuplot")
    vim.opt_local.syntax = "gnuplot"
  elseif filetype == "hy" then
    start_repl("term hy")
    vim.opt_local.syntax = "hy"
  elseif filetype == "coconut" then
    start_repl("term coconut")
  elseif filetype == "dg" then
    start_repl("term python -m dg")
    vim.opt_local.syntax = "dg"
  elseif filetype == "python" then
    ipython_repl = true
    start_repl("term ipython")
  elseif filetype == "nroff" then
    start_repl("term groff -URpetms % -Kutf8 -Tutf8 > %:r.utf8 && less %:r.utf8")
  else
    vim.api.nvim_err_writeln("Filetype " .. filetype .. " not supported.")
  end

end

return M
