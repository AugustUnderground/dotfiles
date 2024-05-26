local vim = vim

vim.g.mapleader      = " "
vim.g.maplocalleader = " "

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

-- Plugins
require("lazy").setup({ { "folke/which-key.nvim"
                        , lazy  = true 
                        , opts  = { }
                        , event = "VeryLazy" }
                      , "godlygeek/tabular"
                      , "nvim-lua/plenary.nvim"
                      , "lewis6991/gitsigns.nvim"
                      , "ryanoasis/vim-devicons"
                      , "nvim-tree/nvim-web-devicons"
                      , { "nvim-telescope/telescope.nvim"
                        , branch       = "0.1.x"
                        , dependencies = { 'nvim-lua/plenary.nvim' } }
                      , { "romgrk/barbar.nvim"
                        , dependencies = { "lewis6991/gitsigns.nvim"
                                         , "nvim-tree/nvim-web-devicons" }
                        , opts = { animation       = true
                                 , insert_at_start = true
                                 , clickable       = true } 
                        , init = function() vim.g.barbar_auto_setup = false end }
                      , { "nvim-neo-tree/neo-tree.nvim"
                        , dependencies = { "nvim-lua/plenary.nvim"
                                         , "nvim-tree/nvim-web-devicons"
                                         , "MunifTanjim/nui.nvim"
                                         , "3rd/image.nvim" }
                        , branch = "v3.x" }
                      , { "nvim-lualine/lualine.nvim"
                        , dependencies = { "nvim-tree/nvim-web-devicons" } }
                      , { "folke/trouble.nvim"
                        , opts         = { } 
                        , dependencies = { "nvim-tree/nvim-web-devicons" } }
                      , { "unblevable/quick-scope" 
                        , init = function() vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" } end
                        , lazy = false }
                      , "norcalli/nvim-colorizer.lua"
                      , "m4xshen/autoclose.nvim"
                      , "chrisbra/csv.vim"
                      , "dhruvasagar/vim-table-mode"
                      , "jbyuki/venn.nvim"
                      , { "nvim-treesitter/nvim-treesitter"
                        , build = ":TSUpdate" }
                      , { "nvimdev/hlsearch.nvim"
                        , event = "BufRead" }
                      -- JuneGunn
			          , "junegunn/vim-easy-align"
			          , "junegunn/fzf.vim"
                      , "junegunn/goyo.vim"
                      -- T. Pope
                      , "tpope/vim-repeat"
                      , "tpope/vim-surround"
                      -- Languages
                      , "neovim/nvim-lspconfig"
                      , "neovimhaskell/haskell-vim"
                      , "monkoose/fzf-hoogle.vim"
                      , "hasufell/ghcup.vim"
                      , { url = "https://git.sr.ht/~detegr/nvim-bqn" }
                      , "JuliaEditorSupport/julia-vim"
                      -- My Plugins
                      , "augustunderground/vim-skill"
                      , "augustunderground/vim-mathmode"
                      , "augustunderground/vim-hy"
                      , "augustunderground/coconut.vim"
                      , "augustunderground/spectre.vim"
                      , "augustunderground/komau.vim"
                      -- Color Schemes
                      , "aditya-azad/candle-grey"
                      , "jaredgorski/fogbell.vim"
                      , "LuRsT/austere.vim"
                      , "zaki/zazen"
                      , "ryanpcmcquen/true-monochrome_vim"
			          , })

local telescope  = require("telescope.builtin")
local trouble    = require("trouble")
local lualine    = require("lualine")
local colorizer  = require("colorizer")
local autoclose  = require("autoclose")
local treesitter = require("nvim-treesitter.configs")
local hlsearch   = require("hlsearch")
local lsp        = require("lspconfig")
local neotree    = require("neo-tree")

-- Settings
vim.opt.number                = true
vim.opt.relativenumber        = true
vim.opt.cursorline            = true
vim.opt.cursorcolumn          = true
vim.opt.termguicolors         = true
vim.opt.expandtab             = true
vim.opt.tabstop               = 4
vim.opt.shiftwidth            = 2
vim.opt.softtabstop           = 2
vim.o.timeout                 = true
vim.o.timeoutlen              = 500
vim.opt.syntax                = "on"
vim.opt.encoding              = "UTF-8"
vim.opt_local.spell.spelllang = "en_us"
-- vim.opt.shell              = "/bin/bash"
vim.opt.clipboard:append({ 'unnamed', 'unnamedplus' })

-- Functions

-- Highlight 80th column
function toggle_80th_column()
  if vim.o.cc == "80" then
    vim.opt.cc = "0"
  else
    vim.opt.cc = "80"
  end
end

-- Toggle Conceal Level
function toggle_conceal_level()
  if vim.o.conceallevel == 0 then
    vim.opt_local.conceallevel = 2
  else
    vim.opt_local.conceallevel = 0
  end
end

-- Open Terminal
function open_terminal()
  vim.cmd("belowright split")
  vim.cmd("resize -10")
  vim.cmd("term $SHELL")
  vim.opt_local.syntax         = "sh"
  vim.opt_local.modifiable     = true
  vim.opt_local.number         = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn     = "no"
  vim.opt_local.cursorline     = false
  vim.opt_local.cursorcolumn   = false
  vim.cmd.normal("A")
end

-- Keymaps
local opts      = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>s", ":set spell!<CR>", {})
vim.keymap.set("n", "<F7>", ":lua toggle_conceal_level()<CR>", opts)
vim.keymap.set("n", "<F8>", ":lua toggle_80th_column()<CR>", opts)
vim.keymap.set("n", "<F9>", ":lua open_terminal()<CR>", opts)
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

arrows = {"<up>", "<down>", "<left>", "<right>"}
modes  = {"n", "i", "v"}
for _,mode in pairs(modes) do
  for _,arrow in pairs(arrows) do
    vim.keymap.set(mode, arrow, "<nop>")
  end
end

vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", {})
vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", {})

vim.keymap.set("n", "<leader>$", ":call Toggle_math_mode()<CR>a", {})

vim.keymap.set("n", "<leader>ff", telescope.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope.buffers, {})
vim.keymap.set("n", "<leader>fh", telescope.help_tags, {})

for _,k in pairs({"h","j","k","l"}) do
  vim.keymap.set("n", "<C-" .. k .. ">", ":wincmd " .. k .. "<CR>", { silent = true })
end
vim.keymap.set("n", "<C-up>", ":res -2<CR>", opts)
vim.keymap.set("n", "<C-down>", ":res +2<CR>", opts)
vim.keymap.set("n", "<C-left>", ":res -2<CR>", opts)
vim.keymap.set("n", "<C-right>", ":res +2<CR>", opts)

vim.keymap.set("n", "<C-p>", "<Cmd>BufferPrevious<CR>", {})
vim.keymap.set("n", "<C-n>", "<Cmd>BufferNext<CR>", {})
vim.keymap.set("n", "<C-,>", "<Cmd>BufferMovePrevious<CR>", {})
vim.keymap.set("n", "<C-.>", "<Cmd>BufferMoveNext<CR>", {})
vim.keymap.set("n", "<C-1>", "<Cmd>BufferGoto 1<CR>", opts)
vim.keymap.set("n", "<C-2>", "<Cmd>BufferGoto 2<CR>", opts)
vim.keymap.set("n", "<C-3>", "<Cmd>BufferGoto 3<CR>", opts)
vim.keymap.set("n", "<C-4>", "<Cmd>BufferGoto 4<CR>", opts)
vim.keymap.set("n", "<C-5>", "<Cmd>BufferGoto 5<CR>", opts)
vim.keymap.set("n", "<C-6>", "<Cmd>BufferGoto 6<CR>", opts)
vim.keymap.set("n", "<C-7>", "<Cmd>BufferGoto 7<CR>", opts)
vim.keymap.set("n", "<C-8>", "<Cmd>BufferGoto 8<CR>", opts)
vim.keymap.set("n", "<C-9>", "<Cmd>BufferGoto 9<CR>", opts)
vim.keymap.set("n", "<C-0>", "<Cmd>BufferLast<CR>", opts)
-- vim.keymap.set('n', '<C-p>', '<Cmd>BufferPin<CR>', opts)
vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
vim.keymap.set("n", "<A-p>", "<Cmd>BufferPick<CR>", opts)

vim.keymap.set("n", "<C-f>", "<Cmd>Neotree<CR>", opts)

vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end)
vim.keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)

-- REPL vim
vim.keymap.set("n", "<F11>", ":call CompileRun()<CR>", {})
vim.keymap.set("n", "<F12>", ":call InteractiveLoad()<CR>", {})

vim.keymap.set("n", "<leader>l", ":ReplSendLine()<CR>", {silent = true})
vim.keymap.set("n", "<leader>r", ":ReplSendRegion()<CR>", {silent = true})
vim.keymap.set("n", "<leader>R", ":ReplReloadFile()<CR>", {silent = true})

-- Languages
vim.g.haskell_enable_quantification          = 1
vim.g.haskell_enable_recursivedo             = 1
vim.g.haskell_enable_arrowsyntax             = 1
vim.g.haskell_enable_pattern_synonyms        = 1
vim.g.haskell_enable_typeroles               = 1
vim.g.haskell_enable_static_pointers         = 1
vim.g.haskell_backpack                       = 1
vim.g.haskell_classic_highlighting           = 1
vim.g.haskell_indent_disable                 = 0
vim.g.haskell_indent_if                      = 3
vim.g.haskell_indent_case                    = 2
vim.g.haskell_indent_let                     = 4
vim.g.haskell_indent_where                   = 6
vim.g.haskell_indent_before_where            = 2
vim.g.haskell_indent_after_bare_where        = 2
vim.g.haskell_indent_do                      = 3
vim.g.haskell_indent_in                      = 1
vim.g.haskell_indent_guard                   = 4
vim.g.haskell_indent_case_alternative        = 1

vim.g.skill_repl                             = "rlwrap virtuoso -nograph"

-- Plugin Settings
colorizer.setup()
autoclose.setup()
hlsearch.setup()

-- quickscope
vim.g.qs_hi_priority = 1
local qs_colors      = vim.api.nvim_create_augroup("qs_colors", { clear = true })
vim.api.nvim_create_autocmd( "ColorScheme"
                           , { group   = qs_colors
                             , pattern = "*"
                             , command = "highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline" })
vim.api.nvim_create_autocmd( "ColorScheme"
                           , { group   = qs_colors
                             , pattern = "*"
                             , command = "highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline" })

-- lualine
lualine.setup({ options           = { icons_enabled        = true
                                    , theme                = 'auto'
                                    , component_separators = { left = '', right = ''}
                                    , section_separators   = { left = '', right = ''}
                                    -- , component_separators = { left = '', right = ''}
                                    -- , section_separators   = { left = '', right = ''}
                                    , disabled_filetypes   = { statusline = {}
                                                             , winbar     = {}
                                                             , }
                                    , ignore_focus         = {}
                                    , always_divide_middle = true
                                    , globalstatus         = false
                                    , refresh              = { statusline = 1000
                                                             , tabline    = 1000
                                                             , winbar     = 1000 }
                                    , }
              , sections          = { lualine_a = {'mode'}
                                    , lualine_b = {'branch', 'diff', 'diagnostics'}
                                    , lualine_c = {'filename'}
                                    , lualine_x = {'encoding', 'fileformat', 'filetype'}
                                    , lualine_y = {'progress'}
                                    , lualine_z = {'location'}
                                    , }
              , inactive_sections = { lualine_a = {}
                                    , lualine_b = {}
                                    , lualine_c = {'filename'}
                                    , lualine_x = {'location'}
                                    , lualine_y = {}
                                    , lualine_z = {}
                                    , }
              , tabline           = {}
              , winbar            = {}
              , inactive_winbar   = {}
              , extensions        = {}
              , })
-- neo-tree
neotree.setup({ window = { position        = "left"
                         , width           = 30
                         , mapping_options = { noremap = true
                                             , nowait = true }
                         , }
              , })

-- venn
function _G.Toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    vim.cmd[[setlocal ve=all]]
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", opts)
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

-- treesitter
function large_file(lang, buf)
  local max_filesize = 100 * 1024 -- 100 KB
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stats and stats.size > max_filesize then
    return true
  end
end
treesitter.setup({ ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "haskell", "latex" }
                 , sync_install     = false
                 , auto_install     = true
                 , ignore_install   = { "javascript", "rust" }
                 , highlight        = { enable                            = true
                                      , disable                           = { "rust" }
                                      , disable                           = large_file
                                      , additional_vim_regex_highlighting = false }
                 , })
-- Color Scheme
vim.cmd.colorscheme("candle-grey-transparent")
vim.cmd("highlight CursorColumn ctermbg=Gray guibg=#101010")
vim.cmd("highlight CursorLine ctermbg=Gray guibg=#101010")
vim.cmd("highlight ColorColumn ctermbg=Gray guibg=#151515")
