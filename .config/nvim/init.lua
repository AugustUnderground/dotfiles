local io = require("io")
local os = require("os")
local vim = vim

-- Read intro
local intro = {}
for line in io.lines(os.getenv("HOME") .. "/.config/nvim/intro.txt") do
    table.insert(intro, line)
end

-- Setup Globals
vim.g.mapleader          = " "
vim.g.maplocalleader     = " "
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- Initialize Plugin Management
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git"
                , "clone"
                , "--filter=blob:none"
                , "https://github.com/folke/lazy.nvim.git"
                , "--branch=stable" -- latest stable release
                , lazypath
                , })
end
vim.opt.rtp:prepend(lazypath)
local lazy = require("lazy")

-- Load Plugins
local plugins = { { "folke/which-key.nvim"
                  , lazy  = true
                  , event = "VeryLazy"
                  , opts  = { } }
                , { "folke/trouble.nvim"
                  , opts         = { signs = { error       = ""
                                             , warning     = ""
                                             , hint        = ""
                                             , information = ""
                                             , other       = "" } }
                  , dependencies = { "nvim-tree/nvim-web-devicons" } }
                , { "folke/noice.nvim"
                  , event = "VeryLazy"
                  , opts = { }
                  , dependencies = { "MunifTanjim/nui.nvim"
                                   , "rcarriga/nvim-notify" }
                  , }
                , "godlygeek/tabular"
                , "nvim-tree/nvim-web-devicons"
                , "nvim-lua/plenary.nvim"
                , "MunifTanjim/nui.nvim"
                , "rcarriga/nvim-notify"
                , "lewis6991/gitsigns.nvim"
                , "onsails/lspkind.nvim"
                , { "nvim-telescope/telescope.nvim"
                  , branch       = "0.1.x"
                  , dependencies = { 'nvim-lua/plenary.nvim' } }
                , { "romgrk/barbar.nvim"
                  , dependencies = { "lewis6991/gitsigns.nvim"
                                   , "nvim-tree/nvim-web-devicons" }
                  , opts = { animation       = true
                           , insert_at_start = true
                           , clickable       = true
                           , icons           = { filetype = { custom_colors = true } } }
                  , init = function() vim.g.barbar_auto_setup = false end }
                , { "nvim-tree/nvim-tree.lua" }
                , { "nvim-lualine/lualine.nvim"
                  , dependencies = { "nvim-tree/nvim-web-devicons" } }
                , { "unblevable/quick-scope"
                  , init = function() vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" } end
                  , lazy = false }
                , { "brenoprata10/nvim-highlight-colors" }
                , "m4xshen/autoclose.nvim"
                , "dhruvasagar/vim-table-mode"
                , "jbyuki/venn.nvim"
                , { "nvimdev/hlsearch.nvim"
                  , event = "BufRead" }
                , { "L3MON4D3/LuaSnip"
                  , version = "v2.*"
                  , build = "make install_jsregexp" }
                , "xiyaowong/nvim-cursorword"
                , "karb94/neoscroll.nvim"
                , { "lukas-reineke/indent-blankline.nvim"
                  , main = "ibl"
                  , opts = {} }
                -- , "uga-rosa/ccc.nvim"
                , "fedepujol/move.nvim"
                , { "augustunderground/nvim-intro" -- "Yoolayn/nvim-intro"
                  , config = { intro      = intro
                             , color      = "#c0c0c0"
                             , scratch    = true
                             , callback   = function()
                                 vim.opt_local.wrap = false
                                 vim.opt_local.cc   = "0"
                               end
                             , highlights = { ["<Enter>"]  = "#ffffff"
                                            , ["<leader>"] = "#ffffff" } } }
                -- JuneGunn
                , "junegunn/vim-easy-align"
                , { "junegunn/fzf", dir = "~/.fzf", build = "./install --all" }
                , "junegunn/goyo.vim"
                -- T. Pope
                , "tpope/vim-repeat"
                , "tpope/vim-surround"
                -- Languages / Syntax
                , "neovim/nvim-lspconfig"
                , "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim"
                , "hrsh7th/cmp-nvim-lsp"
                , "hrsh7th/cmp-buffer"
                , "hrsh7th/cmp-path"
                , "hrsh7th/cmp-cmdline"
                , "petertriho/cmp-git"
                , "hrsh7th/nvim-cmp"
                , "neovimhaskell/haskell-vim"
                , { "mrcjkb/haskell-tools.nvim"
                  , version = "^3"
                  , lazy    = false }
                , "monkoose/fzf-hoogle.vim"
                , "hasufell/ghcup.vim"
                , { "mlochbaum/BQN", ft = "bqn"
                  , config = function(plugin)
                       vim.opt.rtp:append(plugin.dir .. "/editors/vim")
                     end }
                , "JuliaEditorSupport/julia-vim"
                , "lervag/vimtex"
                , { "chrisbra/csv.vim"
                  , lazy = false }
                , "SergioBonatto/bend-vim"
                , "tarikgraba/vim-liberty"
                , { "ShinKage/idris2-nvim"
                  , dependencies = { "neovim/nvim-lspconfig"
                                   , "MunifTanjim/nui.nvim" } }
                -- My Plugins
                , "augustunderground/vim-skill"
                , "augustunderground/vim-mathmode"
                , "augustunderground/vim-hy"
                , "augustunderground/coconut.vim"
                , "augustunderground/spectre.vim"
                , "augustunderground/nocolor.nvim"
                -- , { dir = "/home/uhlmanny/Workspace/nocolor.nvim" }
                -- Color Schemes
                , "rktjmp/lush.nvim"
                , }

if jit.os == "OSX" then
  plugins = require("osx").setup(plugins)
end

lazy.setup(plugins)

local devicons        = require("nvim-web-devicons")
local telescope       = require("telescope")
local telescopebi     = require("telescope.builtin")
local telescopepv     = require("telescope.previewers")
local trouble         = require("trouble")
local noice           = require("noice")
local lualine         = require("lualine")
local highlightcolors = require("nvim-highlight-colors")
local autoclose       = require("autoclose")
local hlsearch        = require("hlsearch")
local lsp             = require("lspconfig")
local diagnostics     = require("toggle_lsp_diagnostics")
local nvimtree        = require("nvim-tree")
local luasnip         = require("luasnip")
-- local ccc             = require("ccc")
local move            = require("move")
local cmpgit          = require("cmp_git")
local cmp             = require("cmp")
local cmplsp          = require("cmp_nvim_lsp")
local lspkind         = require("lspkind")
local neoscroll       = require("neoscroll")
local ibl             = require("ibl")
local nocolor         = require("nocolor.lualine")
local repl            = require("repl")
local haskell         = require("haskell-tools")

-- Settings
vim.o.timeout          = true
vim.o.timeoutlen       = 500
vim.o.updatetime       = 250
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.cursorcolumn   = true
vim.opt.termguicolors  = true
vim.opt.guifont        = "VictorMono Nerd Font Mono:h12"
vim.opt.expandtab      = true
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 2
vim.opt.softtabstop    = 2
vim.opt.conceallevel   = 2
vim.opt.syntax         = "on"
vim.opt.encoding       = "UTF-8"
vim.opt.cc             = "80"
-- vim.opt.shell          = "/bin/bash"

vim.opt_local.spell.spelllang = "en_us"
vim.opt.clipboard:append({ 'unnamed', 'unnamedplus' })

-- Languages / Syntax

vim.api.nvim_create_autocmd( { "BufRead", "BufNewFile" }
                           , { pattern  = "*.bend"
                             , callback = function()
                               vim.bo.filetype = "bend"
                               vim.bo.syntax   = "bend"
                             end })

-- require("idris2").setup({})

-- Functions

-- Highlight 80th column
function Toggle80thColumn()
  if vim.o.cc == "80" then
    vim.opt.cc = "0"
  else
    vim.opt.cc = "80"
  end
end

-- Toggle Conceal Level
function ToggleConcealLevel()
  if vim.o.conceallevel == 0 then
    vim.opt_local.conceallevel = 2
  else
    vim.opt_local.conceallevel = 0
  end
end

-- Open Terminal
function OpenTerminal()
  vim.cmd("belowright split")
  vim.cmd("resize -10")
  vim.cmd("term $SHELL")
  -- vim.opt_local.syntax         = "sh"
  vim.opt_local.modifiable     = true
  vim.opt_local.number         = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn     = "no"
  vim.opt_local.cursorline     = false
  vim.opt_local.cursorcolumn   = false
  -- vim.cmd("CursorWordDisable")
  vim.cmd.normal("A")
end

-- Keymaps
local bufnr   = vim.api.nvim_get_current_buf()
local opts    = { noremap = true, silent = true }
local hstOpts = { noremap = true, silent = true, buffer = bufnr }

vim.keymap.set("n", "<leader>s", ":set spell!<CR>", {})
vim.keymap.set("n", "<F7>", ":lua ToggleConcealLevel()<CR>", opts)
vim.keymap.set("n", "<F8>", ":lua Toggle80thColumn()<CR>", opts)
vim.keymap.set("n", "<F9>", ":lua OpenTerminal()<CR>", opts)
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

-- vim.keymap.set("n", "<leader>cp", ":r!colorpicker --one-short --short<CR>", {noremap = true})
vim.cmd("noremap <leader>cp :r!colorpicker --one-shot --short<CR>")

-- German special characters: ä, ö, ü, ß
local german_group = vim.api.nvim_create_augroup("german_group", { clear = true })
vim.api.nvim_create_autocmd( { "BufNewFile", "BufRead" }
                           , { pattern  = "*"
                             , group    = german_group
                             , callback = function()
                                vim.keymap.set("i", "\\ae", "ä")
                                vim.keymap.set("i", "\\oe", "ö")
                                vim.keymap.set("i", "\\ue", "ü")
                                vim.keymap.set("i", "\\Ae", "Ä")
                                vim.keymap.set("i", "\\Oe", "Ö")
                                vim.keymap.set("i", "\\Ue", "Ü")
                                vim.keymap.set("i", "\\ss", "ß")
                             end })
vim.api.nvim_create_autocmd( { "BufNewFile", "BufRead" }
                           , { pattern  = {"*.tex", "*.bib", "*.sty"}
                             , group    = german_group
                             , callback = function()
                                vim.keymap.set("i", "\\ae", "\\\"{a}")
                                vim.keymap.set("i", "\\oe", "\\\"{o}")
                                vim.keymap.set("i", "\\ue", "\\\"{u}")
                                vim.keymap.set("i", "\\Ae", "\\\"{A}")
                                vim.keymap.set("i", "\\Oe", "\\\"{O}")
                                vim.keymap.set("i", "\\Ue", "\\\"{U}")
                                vim.keymap.set("i", "\\ss", "{\\ss}")
                             end })
vim.api.nvim_create_autocmd( { "BufNewFile", "BufRead" }
                           , { pattern  = {"*.nroff", "*.groff", "*.roff"}
                             , group    = german_group
                             , callback = function()
                                vim.keymap.set("i", "\\ae", "\\[:a]")
                                vim.keymap.set("i", "\\oe", "\\[:o]")
                                vim.keymap.set("i", "\\ue", "\\[:u]")
                                vim.keymap.set("i", "\\Ae", "\\[:A]")
                                vim.keymap.set("i", "\\Oe", "\\[:O]")
                                vim.keymap.set("i", "\\Ue", "\\[:U]")
                                vim.keymap.set("i", "\\ss", "\\[ss]")
                             end })

local arrows = {"<up>", "<down>", "<left>", "<right>"}
local modes  = {"n", "i", "v"}
for _,mode in pairs(modes) do
  for _,arrow in pairs(arrows) do
    vim.keymap.set(mode, arrow, "<nop>")
  end
end

vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", {})
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", {})

vim.keymap.set("n", "<leader>df", "<Plug>(toggle-lsp-diag-off)", {})
vim.keymap.set("n", "<leader>do", "<Plug>(toggle-lsp-diag-on)", {})

vim.keymap.set("n", "<leader>$", ":call Toggle_math_mode()<CR>a", {})

vim.keymap.set("n", "<leader>ff", telescopebi.find_files, {})
vim.keymap.set("n", "<leader>fg", telescopebi.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescopebi.buffers, {})
vim.keymap.set("n", "<leader>fh", telescopebi.help_tags, {})

for _,k in pairs({"h","j","k","l"}) do
  vim.keymap.set("n", "<C-" .. k .. ">", ":wincmd " .. k .. "<CR>", { silent = true })
end
vim.keymap.set("n", "<C-up>", ":res -2<CR>", opts)
vim.keymap.set("n", "<C-down>", ":res +2<CR>", opts)
vim.keymap.set("n", "<C-left>", ":res -2<CR>", opts)
vim.keymap.set("n", "<C-right>", ":res +2<CR>", opts)

vim.keymap.set("n", "<C-p>", "<cmd>BufferPrevious<CR>", {})
vim.keymap.set("n", "<C-n>", "<cmd>BufferNext<CR>", {})
vim.keymap.set("n", "<C-,>", "<cmd>BufferMovePrevious<CR>", {})
vim.keymap.set("n", "<C-.>", "<cmd>BufferMoveNext<CR>", {})
vim.keymap.set("n", "<C-1>", "<cmd>BufferGoto 1<CR>", opts)
vim.keymap.set("n", "<C-2>", "<cmd>BufferGoto 2<CR>", opts)
vim.keymap.set("n", "<C-3>", "<cmd>BufferGoto 3<CR>", opts)
vim.keymap.set("n", "<C-4>", "<cmd>BufferGoto 4<CR>", opts)
vim.keymap.set("n", "<C-5>", "<cmd>BufferGoto 5<CR>", opts)
vim.keymap.set("n", "<C-6>", "<cmd>BufferGoto 6<CR>", opts)
vim.keymap.set("n", "<C-7>", "<cmd>BufferGoto 7<CR>", opts)
vim.keymap.set("n", "<C-8>", "<cmd>BufferGoto 8<CR>", opts)
vim.keymap.set("n", "<C-9>", "<cmd>BufferGoto 9<CR>", opts)
vim.keymap.set("n", "<C-0>", "<cmd>BufferLast<CR>", opts)
-- vim.keymap.set('n', '<C-p>', '<cmd>BufferPin<CR>', opts)
vim.keymap.set('n', '<A-c>', '<cmd>BufferClose<CR>', opts)
vim.keymap.set("n", "<A-p>", "<cmd>BufferPick<CR>", opts)

vim.keymap.set("n", "<leader>ft", "<cmd>NvimTreeOpen<CR>", opts)

vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end)
vim.keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)

-- vim.keymap.set({"i"}, "<Tab>", function() ls.expand() end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set("n", "<F11>",     repl.compile_and_run, {})
vim.keymap.set("n", "<F12>",     repl.start_repl, {})
vim.keymap.set("n", "<leader>l", repl.repl_send_line, {silent = true})
vim.keymap.set("n", "<leader>r", repl.repl_send_region, {silent = true})
vim.keymap.set("n", "<leader>R", repl.repl_reload_file, {silent = true})

vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, hstOpts)
vim.keymap.set("n", "<leader>hs", haskell.hoogle.hoogle_signature, hstOpts)

vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)
vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)

vim.api.nvim_create_autocmd( "LspAttach"
                           , { desc = "LSP actions"
                             , callback = function(event)
                                  local bufmap = function(mode, lhs, rhs)
                                    local kopts   = {buffer = event.buf}
                                    vim.keymap.set(mode, lhs, rhs, kopts)
                                  end
                                  -- bufmap("i", "<C-Space>", "<C-x><C-o>")
                                  bufmap("n", "<S-k>", "<cmd>lua vim.lsp.buf.hover()<cr>")
                                  bufmap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
                                  bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
                                  bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
                                  bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
                                  bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
                                  bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
                                  bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
                                  bufmap("n", "<F3>", "<cmd>lua vim.lsp.buf.format()<cr>")
                                  bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
                                  bufmap("n", "<leader>ds", "<cmd>lua vim.lsp.diagnostic.open_float()<cr>")
                                end } )

-- haskell 
vim.g.haskell_enable_quantification   = 1
vim.g.haskell_enable_recursivedo      = 1
vim.g.haskell_enable_arrowsyntax      = 1
vim.g.haskell_enable_pattern_synonyms = 1
vim.g.haskell_enable_typeroles        = 1
vim.g.haskell_enable_static_pointers  = 1
vim.g.haskell_backpack                = 1
vim.g.haskell_classic_highlighting    = 1
vim.g.haskell_indent_disable          = 0
vim.g.haskell_indent_if               = 3
vim.g.haskell_indent_case             = 2
vim.g.haskell_indent_let              = 4
vim.g.haskell_indent_where            = 6
vim.g.haskell_indent_before_where     = 2
vim.g.haskell_indent_after_bare_where = 2
vim.g.haskell_indent_do               = 3
vim.g.haskell_indent_in               = 1
vim.g.haskell_indent_guard            = 4
vim.g.haskell_indent_case_alternative = 1

-- SKILL
vim.g.skill_repl                      = "rlwrap virtuoso -nograph"

-- Plugin Setup
devicons.setup({ color_icons = false
               , default     = true
               , strict      = true })

autoclose.setup()
hlsearch.setup()
diagnostics.init()
ibl.setup()

-- highlightcolors
highlightcolors.setup({ render              = "background"
                      , enable_hex          = true
                      , enable_rgb          = true
                      , enable_hsl          = true
                      , enable_var_usage    = true
                      , enable_named_colors = true
                      , enable_tailwind     = false })

-- cursorword
vim.g.cursorword_disable_filetypes = { "tex", "NvimTree", "markdown", "roff", "text" }
vim.g.cursorword_min_width         = 3
vim.g.cursorword_max_width         = 50

-- neoscroll
neoscroll.setup({ mappings             = { "<C-u>", "<C-d>", "<C-b>", "<C-f>"
                                         , "<C-y>", "<C-e>", "zt", "zz", "zb" }
                , hide_cursor          = false
                , stop_eof             = false
                , respect_scrolloff    = false
                , cursor_scrolls_alone = true
                , easing               = "linear"
                , pre_hook             = nil
                , post_hook            = nil
                , performance_mode     = false })

-- noice
noice.setup({ lsp     = { override = { ["vim.lsp.util.convert_input_to_markdown_lines"] = true
                                     , ["vim.lsp.util.stylize_markdown"]                = true
                                     , ["cmp.entry.get_documentation"]                  = true } }
            , presets = { bottom_search = true
                        , command_palette = true
                        , long_message_to_split = true
                        , inc_rename = false
                        , lsp_doc_border = false }
            , })

-- quickscope
vim.g.qs_hi_priority = 1

-- telescope
telescope.setup({ defaults = { color_devicons = false
                             , buffer_previewer_maker = function(fn, bn, op)
                                  op = op or {}
                                  if fn:match(".*%.csv") then opts.use_ft_detect = false end
                                  telescopepv.buffer_previewer_maker(fn,bn,op)
                                end
                             , } })

-- lualine
lualine.setup({ options           = { icons_enabled        = true
                                    , theme                = nocolor
                                    , component_separators = { left = "", right = ""}
                                    , section_separators   = { left = "", right = ""}
                                    , disabled_filetypes   = { statusline = {'NvimTree'}
                                                             , winbar     = {'NvimTree'}
                                                             , }
                                    , ignore_focus         = {}
                                    , always_divide_middle = true
                                    , globalstatus         = false
                                    , refresh              = { statusline = 1000
                                                             , tabline    = 1000
                                                             , winbar     = 1000 }
                                    , }
              , sections          = { lualine_a = {"mode"}
                                    , lualine_b = {"branch", "diff", "diagnostics"}
                                    , lualine_c = {"filename"}
                                    , lualine_x = {{"filetype", colored = false}}
                                    , lualine_y = {"encoding", "fileformat", "progress"}
                                    , lualine_z = {"location"}
                                    , }
              , inactive_sections = { lualine_a = {}
                                    , lualine_b = {}
                                    , lualine_c = {"filename"}
                                    , lualine_x = {"location"}
                                    , lualine_y = {}
                                    , lualine_z = {}
                                    , }
              , tabline           = {}
              , winbar            = {}
              , inactive_winbar   = {}
              , extensions        = {}
              , })

-- nvimtree
nvimtree.setup({ sort = { sorter = "case_sensitive" }
               , view = { width = 30
                        , preserve_window_proportions = true }
               , renderer = { group_empty = true
                            , icons = { web_devicons = { file = { enable = true
                                                                , color  = false }
                                                       , folder = { enable = false
                                                                  , color = false }
                                                       , }
                                      , }
                            , }
               , filters = { dotfiles = true } })

-- venn
function _G.Toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    vim.cmd[[setlocal ve=all]]
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>",       { noremap = true })
  else
    vim.cmd[[setlocal ve=]]
    vim.api.nvim_buf_del_keymap(0, "n", "J")
    vim.api.nvim_buf_del_keymap(0, "n", "K")
    vim.api.nvim_buf_del_keymap(0, "n", "L")
    vim.api.nvim_buf_del_keymap(0, "n", "H")
    vim.api.nvim_buf_del_keymap(0, "v", "f")
    vim.b.venn_enabled = nil
  end
end
vim.api.nvim_set_keymap("n", "<leader>v", ":lua Toggle_venn()<CR>", opts)

-- Color Picker CCC
-- ccc.setup({})

-- Move Lines and Blocks
move.setup({ line  = { enable = true
                     , indent = false }
           , block = { enable = true
                     , indent = false }
           , word  = { enable = true }
           , char  = { enable = true } })

-- cmp
cmp.setup({ snippet = { expand = function(args) luasnip.lsp_expand(args.body) end }
          , window  = { -- completion = cmp.config.window.bordered(),
                      -- , documentation = cmp.config.window.bordered(),
                      }
          , mapping = cmp.mapping.preset.insert({ ["<C-b>"]     = cmp.mapping.scroll_docs(-4)
                                                , ["<C-f>"]     = cmp.mapping.scroll_docs(4)
                                                , ["<C-Space>"] = cmp.mapping.complete()
                                                , ["<Tab>"]     = cmp.mapping.select_next_item()
                                                , ["<S-Tab>"]   = cmp.mapping.select_prev_item()
                                                , ["<C-e>"]     = cmp.mapping.abort()
                                                , ["<CR>"]      = cmp.mapping.confirm({ select = true })
                                                , })
          , sources = cmp.config.sources({ { name = "nvim_lsp" }
                                         , { name = "luasnip" }
                                         , { name = "path" } }
                                        , { { name = "buffer" } })
          , formatting = { format = function(entry, vim_item)
                if vim.tbl_contains({ "path" }, entry.source.name) then
                  local icon, _ = devicons.get_icon(entry:get_completion_item().label)
                  if icon then
                    vim_item.kind          = icon
                    vim_item.kind_hl_group = Pmenu
                    return vim_item
                  end
                end
                return lspkind.cmp_format({ with_text = false })(entry, vim_item)
              end }
          , })
cmp.setup.filetype("gitcommit", { sources = cmp.config.sources( { { name = "git" } }
                                                              , { { name = "buffer" } } ) })
cmpgit.setup()

cmp.setup.cmdline( { "/", "?" }
                 , { mapping = cmp.mapping.preset.cmdline()
                   , sources = { { name = "buffer" } } })

cmp.setup.cmdline(":", { mapping  = cmp.mapping.preset.cmdline()
                       , sources  = cmp.config.sources( { { name = "path" } }
                                                     , { { name = "cmdline" } } )
                       , matching = { disallow_symbol_nonprefix_matching = false } })

-- lsp config
vim.diagnostic.config({ virtual_text = false })
-- vim.diagnostic.disable()
vim.cmd("autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})")

local capabilities = cmplsp.default_capabilities()

-- lsp["hls"].setup({ capabilities = capabilities })
lsp["texlab"].setup({ capabilities = capabilities })
lsp["lua_ls"].setup({ capabilities = capabilities })
lsp["pyright"].setup({ capabilities = capabilities})
lsp["idris2_lsp"].setup({ capabilities = capabilities })
lsp["ocamllsp"].setup({ capabilities = capabilities })
lsp["fortls"].setup({ capabilities = capabilities })
lsp["julials"].setup({ capabilities = capabilities })

if jit.os == "OSX" then
  lsp["sourcekit"].setup({ capabilities = capabilities })
end

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Goyo
local goyo_group = vim.api.nvim_create_augroup("GoyoGroup", { clear = true })
vim.api.nvim_create_autocmd("User", { desc     = "Hide lualine on goyo enter"
                                    , group    = goyo_group
                                    , pattern  = "GoyoEnter"
                                    , callback = function()
                                        require("lualine").hide()
                                      end
                                    , })
vim.api.nvim_create_autocmd("User", { desc     = "Show lualine after goyo exit"
                                    , group    = goyo_group
                                    , pattern  = "GoyoLeave"
                                    , callback = function()
                                        require("lualine").hide({ unhide = true })
                                      end
                                    , })

-- Color Scheme
vim.cmd.colorscheme("nocolor")

-- NeoVide
vim.g.neovide_refresh_rate                 = 144       -- refresh rate of gfx window
vim.g.neovide_transparency                 = 1.0       -- window background opacity
vim.g.neovide_no_idle                      = false     -- immediately redraw
vim.g.neovide_fullscreen                   = false     -- borderless windowed full screen
vim.g.neovide_cursor_vfx_mode              = "railgun" -- cursor animation style [railgun|torpedo|pixiedust|sonicboom|ripple|wireframe]
vim.g.neovide_cursor_animation_length      = 0.1       -- cursor animation time in ms
vim.g.neovide_cursor_trail_length          = 0.1       -- cursor trail length during animation
vim.g.neovide_cursor_antialiasing          = true      -- cursor animation antialising
vim.g.neovide_cursor_vfx_opacity           = 200.0     -- transparency of particle effects
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2       -- duration of particle effects in s
vim.g.neovide_cursor_vfx_particle_density  = 7.0       -- density of particle effects
vim.g.neovide_cursor_vfx_particle_speed    = 10.0      -- velocity of particle effects
vim.g.neovide_cursor_vfx_particle_phase    = 1.5       -- ?
vim.g.neovide_cursor_vfx_particle_curl     = 1.0       -- ?
