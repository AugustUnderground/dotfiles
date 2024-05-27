local vim = vim

vim.g.mapleader      = " " vim.g.maplocalleader = " "

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

-- Plugins
lazy.setup({ { "folke/which-key.nvim"
             , lazy  = true 
             , opts  = { }
             , event = "VeryLazy" }
           , "godlygeek/tabular"
           , "nvim-lua/plenary.nvim"
           , "lewis6991/gitsigns.nvim"
           , "ryanoasis/vim-devicons"
           , "nvim-tree/nvim-web-devicons"
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
                      , icons = { filetype = { custom_colors = true } } } 
             , init = function() vim.g.barbar_auto_setup = false end }
           , { "nvim-neo-tree/neo-tree.nvim"
             , dependencies = { "nvim-lua/plenary.nvim"
                              , "nvim-tree/nvim-web-devicons"
                              , "MunifTanjim/nui.nvim"
                              , "3rd/image.nvim" }
             , branch       = "v3.x"
             , pin          = true }
           , { "nvim-lualine/lualine.nvim"
             , dependencies = { "nvim-tree/nvim-web-devicons" } }
           , { "folke/trouble.nvim"
             , opts         = { signs = { error       = ""
                                        , warning     = ""
                                        , hint        = ""
                                        , information = ""
                                        , other       = "" } }
             , dependencies = { "nvim-tree/nvim-web-devicons" } }
           , { "unblevable/quick-scope" 
             , init = function() vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" } end
             , lazy = false }
           , "norcalli/nvim-colorizer.lua"
           , "m4xshen/autoclose.nvim"
           , "chrisbra/csv.vim"
           , "dhruvasagar/vim-table-mode"
           , "jbyuki/venn.nvim"
           , { "nvimdev/hlsearch.nvim"
             , event = "BufRead" }
           , { "L3MON4D3/LuaSnip"
		 , version = "v2.*"
		 , build = "make install_jsregexp" }
           -- JuneGunn
		   , "junegunn/vim-easy-align"
		   , "junegunn/fzf.vim"
           , "junegunn/goyo.vim"
           -- T. Pope
           , "tpope/vim-repeat"
           , "tpope/vim-surround"
           -- Languages
           -- , { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }
           -- , "ray-x/cmp-treesitter"
           , "neovim/nvim-lspconfig"
           , "hrsh7th/cmp-nvim-lsp"
           , "hrsh7th/cmp-buffer"
           , "hrsh7th/cmp-path"
           , "hrsh7th/cmp-cmdline"
           , "petertriho/cmp-git"
           , "hrsh7th/nvim-cmp"
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
           -- My Plugins
           , "augustunderground/vim-skill"
           , "augustunderground/vim-mathmode"
           , "augustunderground/vim-hy"
           , "augustunderground/coconut.vim"
           , "augustunderground/spectre.vim"
           , "augustunderground/nocolor.nvim"
           -- , { dir = "/home/uhlmanny/Workspace/nocolor.nvim", lazy = true }
           -- Color Schemes
           , "rktjmp/lush.nvim"
           , "aditya-azad/candle-grey"
		   , })

local telescope  = require("telescope.builtin")
local trouble    = require("trouble")
local lualine    = require("lualine")
local colorizer  = require("colorizer")
local autoclose  = require("autoclose")
-- local treesitter = require("nvim-treesitter.configs")
local hlsearch   = require("hlsearch")
local lsp        = require("lspconfig")
local neotree    = require("neo-tree")
local luasnip    = require("luasnip")
local cmpgit     = require("cmp_git")
local cmp        = require("cmp")
local cmplsp     = require("cmp_nvim_lsp")
local devicons   = require("nvim-web-devicons")
local lspkind    = require("lspkind")

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
-- vim.opt.shell                 = "/bin/bash"
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

-- vim.keymap.set({"i"}, "<Tab>", function() ls.expand() end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set("n", "<F11>", ":call CompileRun()<CR>", {})
vim.keymap.set("n", "<F12>", ":call InteractiveLoad()<CR>", {})
vim.keymap.set("n", "<leader>l", ":ReplSendLine()<CR>", {silent = true})
vim.keymap.set("n", "<leader>r", ":ReplSendRegion()<CR>", {silent = true})
vim.keymap.set("n", "<leader>R", ":ReplReloadFile()<CR>", {silent = true})

vim.api.nvim_create_autocmd( "LspAttach"
                           , { desc = "LSP actions"
                             , callback = function(event)
                                  local bufmap = function(mode, lhs, rhs)
                                    local opts   = {buffer = event.buf}
                                    vim.keymap.set(mode, lhs, rhs, opts)
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
                                end } )

-- Languages
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

vim.g.skill_repl                      = "rlwrap virtuoso -nograph"

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
                                    , theme                = "auto"
                                    , component_separators = { left = "", right = ""}
                                    , section_separators   = { left = "", right = ""} 
                                    -- , component_separators = { left = "", right = ""}
                                    -- , section_separators   = { left = "", right = ""}
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
-- neo-tree
neotree.setup({ window = { position        = "left"
                         , width           = 30
                         , mapping_options = { noremap = true
                                             , nowait  = true } }
              , default_component_configs = { name = { trailing_slash        = true
                                                     , use_git_status_colors = false
                                                   } }
              , })
-- vim.api.nvim_set_hl(0, "NeoTreeFileIcon", { link="NeoTreeFileName" })

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
-- function large_file(lang, buf)
--   local max_filesize = 100 * 1024 -- 100 KB
--   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--   if ok and stats and stats.size > max_filesize then
--     return true
--   end
-- end
-- treesitter.setup({ ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "haskell", "latex" }
--                  , sync_install     = false
--                  , auto_install     = true
--                  , ignore_install   = { "javascript", "rust" }
--                  , highlight        = { enable                            = true
--                                       , disable                           = { "rust" }
--                                       , disable                           = large_file
--                                       , additional_vim_regex_highlighting = false }
--                  , })

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
                                         , { name = "path" } 
                                         , { name = "treesitter" } }
                                        , { { name = "buffer" } })
          , formatting = { format = function(entry, vim_item)
                if vim.tbl_contains({ "path" }, entry.source.name) then
                  local icon, hl_group = devicons.get_icon(entry:get_completion_item().label)
                  if icon then
                    vim_item.kind          = icon
                    vim_item.kind_hl_group = hl_group
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
lsp.texlab.setup({})
local capabilities = cmplsp.default_capabilities()
lsp["texlab"].setup({ capabilities = capabilities })

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Color Scheme
vim.cmd.colorscheme("nocolor")
