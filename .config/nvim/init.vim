" Only in bash
set shell=/bin/bash

" Vim Plug config
call plug#begin('~/.vim/plugged')
" Plugins
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'mattn/calendar-vim'
Plug 'Shougo/unite.vim'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'jceb/vim-orgmode'
Plug 'vimwiki/vimwiki'
Plug 'vim-scripts/utl.vim'
Plug 'cohama/lexima.vim'
Plug 'luochen1990/rainbow'
Plug 'chrisbra/csv.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'trapd00r/vimpoint'
Plug 'jpalardy/vim-slime'
Plug 'unblevable/quick-scope'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'segeljakt/vim-isotope'
Plug 'vim-scripts/DrawIt'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'liuchengxu/vim-which-key'
"Plug 'wfxr/minimap.vim'
Plug 'lifepillar/vim-colortemplate'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'jbyuki/nabla.nvim'
"Plug 'shadmansaleh/colorscheme_generator.nvim'
"Plug 'puremourning/vimspector'
Plug 'rootkiter/vim-hexedit'
Plug 'rbgrouleff/bclose.vim' " GHCup dependency
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"Plug 'nosduco/remote-sshfs.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'lambdalisue/nerdfont.vim'
Plug 'nvimdev/hlsearch.nvim'
"Plug 'animated-search-highlight.nvim'
Plug 'godlygeek/tabular'

" junegunn
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" tpope
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vividchalk'
Plug 'tpope/vim-eunuch'

" Language
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
Plug 'vim-scripts/coq-syntax'
Plug 'da-h/AirLatex.vim', {'do': ':UpdateRemotePlugins'}
Plug 'ziglang/zig.vim'
Plug 'vim-skk/eskk.vim'
Plug 'vim-skk/skkdict.vim'
Plug 'mlochbaum/BQN', {'rtp': 'editors/vim'}
Plug 'https://git.sr.ht/~detegr/nvim-bqn'
Plug 'rubik/vim-dg'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
"Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }
"Plug 'vim-syntastic/syntastic'
Plug 'McSinyx/vim-octave'
"Plug 'hylang/vim-hy'
Plug 'ARM9/arm-syntax-vim'
Plug 'SkyLeach/pudb.vim'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'wlangstroth/vim-racket'
"Plug 'davidhalter/jedi-vim'
Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'manicmaniac/coconut.vim'
Plug 'arrufat/vala.vim'
Plug 'elmcast/elm-vim'
Plug 'voldikss/vim-mma'
Plug 'tbastos/vim-lua'
Plug 'cespare/vim-toml'
Plug 'lervag/vimtex'
Plug 'alvan/vim-closetag'
Plug 'melrief/vim-frege-syntax'
Plug 'purescript-contrib/purescript-vim'
Plug 'sriharshachilakapati/vimmer-ps'
Plug 'neovimhaskell/haskell-vim'
Plug 'monkoose/fzf-hoogle.vim'
Plug 'hasufell/ghcup.vim'
Plug 'vim-scripts/SyntaxAttr.vim'
Plug 'derekelkins/agda-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'xbase-lab/xbase', { 'do': 'make install' }

" My
Plug 'augustunderground/vim-skill'
Plug 'augustunderground/vim-mathmode'
Plug 'augustunderground/vim-hy'
Plug 'augustunderground/coconut.vim'
Plug 'augustunderground/spectre.vim'
Plug 'augustunderground/gothic.nvim'
Plug 'augustunderground/komau.vim'

" Colorschemes
"Plug 'kjwon15/vim-transparent'
Plug 'metalelf0/base16-black-metal-scheme'
Plug 'sts10/vim-pink-moon'
Plug 'sainnhe/edge'
Plug 'TheAtlasEngine/PastelColors'
Plug 'jcherven/jummidark.vim'
Plug 'lewis6991/moonlight.vim'
Plug 'liuchengxu/space-vim-dark'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tssm/c64-vim-color-scheme'
Plug 'sonjapeterson/1989.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'tomasr/molokai'
Plug 'NLKNguyen/papercolor-theme'
Plug 'gryf/wombat256grf'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'itchyny/landscape.vim'
Plug 'dguo/blood-moon', {'rtp': 'applications/vim'}
Plug 'widatama/vim-phoenix'
Plug 'owozsh/amora'
Plug 'plan9-for-vimspace/acme-colors'
Plug 'huyvohcmc/atlas.vim'
Plug 'mcchrish/zenbones.nvim'
Plug 'Jorengarenar/vim-darkness'

call plug#end()

" File Type specific settings
au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7
au BufNewFile,BufRead *.fish set filetype=fish
au BufNewFile,BufRead *.jl set filetype=julia
au BufNewFile,BufRead *.rkt set filetype=racket
au BufNewFile,BufRead *.tex set filetype=tex
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.bib set filetype=bib
au BufNewFile,BufRead *.java set filetype=java
au BufNewFile,BufRead *.il,*.ils set filetype=skill
au BufNewFile,BufRead *.net,*.mod set filetype=spice
au BufNewFile,BufRead *.agda set filetype=agda
au BufNewFile,BufRead *.v set filetype=coq
"au BufNewFile,BufRead *.m set filetype=matlab
au BufNewFile,BufRead *.py let g:repl_ipython = 1
"au BufNewFile,BufRead *.coco let g:repl_ipython = 1
au BufNewFile,BufRead *.hs let g:repl_ghci = 1
au BufNewFile,BufRead *.fr let g:repl_ghci = 1
au BufNewFile,BufRead *.hy set tabstop=4 shiftwidth=4 softtabstop=4
au BufNewFile,BufRead *.* call MapGermanCharacters()

filetype on
filetype plugin on
filetype plugin indent on

" let g:opamshare = substitute(system('opam config var share'),'\n$','','''') 
" execute "set rtp+=" . g:opamshare . "/merlin/vim"

set hidden
set showtabline=2

" Color settings
set termguicolors
set guifont=GoMono\ Nerd\ Font\ 11

augroup qs_colors
    autocmd!
    autocmd ColorScheme * hi QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    autocmd ColorScheme * hi QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
    autocmd ColorScheme * hi Search cterm=NONE ctermfg=black ctermbg=yellow
    autocmd ColorScheme * hi CursorLine term=NONE cterm=NONE ctermbg=0
    autocmd ColorScheme * hi CursorColumn term=NONE cterm=NONE ctermbg=0
    autocmd ColorScheme * hi Normal ctermbg=none
    autocmd ColorScheme * hi NonText ctermbg=none
    autocmd ColorScheme * hi LineNr ctermbg=none
augroup END

"set fillchars+=vert:\ 

" Plugin Settings
" let g:AirLatexUsername                       = "augustunderground@pm.me"
let g:AirLatexUsername                       = "cookies:CO2niYza0oH0-QE"
let g:python3_host_prog                      = trim(system('which python3'))
let g:magma_automatically_open_output        = v:true
let g:dg_highlight_builtin_objs              = 1
let g:dg_highlight_builtin_funcs             = 1
let g:dg_highlight_exceptions                = 1
let g:dg_highlight_indent_errors             = 1
let g:dg_highlight_space_errors              = 1
let g:haskell_enable_quantification          = 1
let g:haskell_enable_recursivedo             = 1
let g:haskell_enable_arrowsyntax             = 1
let g:haskell_enable_pattern_synonyms        = 1
let g:haskell_enable_typeroles               = 1
let g:haskell_enable_static_pointers         = 1
let g:haskell_backpack                       = 1
let g:haskell_classic_highlighting           = 1
let g:haskell_indent_disable                 = 0
let g:haskell_indent_if                      = 3
let g:haskell_indent_case                    = 2
let g:haskell_indent_let                     = 4
let g:haskell_indent_where                   = 6
let g:haskell_indent_before_where            = 2
let g:haskell_indent_after_bare_where        = 2
let g:haskell_indent_do                      = 3
let g:haskell_indent_in                      = 1
let g:haskell_indent_guard                   = 4
let g:haskell_indent_case_alternative        = 1
let g:skill_repl                             = 'rlwrap virtuoso -nograph'
let g:minimap_width                          = 15
let g:minimap_auto_start                     = 0
let g:minimap_auto_start_win_enter           = 0
let g:minimap_highlight                      = 'Search'
let g:minimap_base_highlight                 = 'Normal'
let g:minimap_block_filetypes                = [ 'fugitive', 'nerdtree'
                                             \ , 'tagbar', 'lightline' ]
let g:minimap_block_buftypes                 = [ 'nofile', 'nowrite'
                                             \ , 'quickfix', 'terminal'
                                             \ , 'prompt' ]
let g:minimap_close_filetypes                = ['startify', 'netrw', 'vim-plug']
let g:minimap_close_buftypes                 = [ ]
let g:minimap_left                           = 0
let g:minimap_highlight_range                = 0
let g:eskk#large_dictionary                  = { 'path': '/usr/share/skk/SKK-JISYO.L'
                                             \ , 'sorted': 1
                                             \ , 'encoding': 'euc-jp' }
let g:elm_setup_keybindings                  = 0
let g:lightline#bufferline#show_number       = 1
let g:lightline#bufferline#shorten_path      = 0
let g:lightline#bufferline#unnamed           = '[No Name]'
let g:lightline#bufferline#enable_nerdfont   = 1
let g:lightline                              = {}
let g:lightline                              = { 'colorscheme': 'komau'
                                             \ , 'separator': { 'left': ''
                                                            \ , 'right': ''  
                                                            \ }
                                             \ , 'subseparator': { 'left': '' 
                                                               \ , 'right': ''
                                                               \ }
                                             \ , 'component_function': { 'filetype':   'MyFiletype'
                                                                     \ , 'fileformat': 'MyFileformat'
                                                                     \ }
                                             \ }
let g:lightline.tabline                      = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand             = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type               = {'buffers': 'tabsel'}
au BufWritePost,TextChanged,TextChangedI * call lightline#update()
let g:syntastic_enable_racket_racket_checker = 1
let g:syntastic_always_populate_loc_list     = 1
let g:syntastic_auto_loc_list                = 1
let g:elm_syntastic_show_warnings            = 1
" let g:indentLine_char_list                   = ['|', '¦', '┆', '┊']
let g:vimspector_enable_mappings             = 'HUMAN'
let g:colorizer_auto_color                   = 0
let g:colorizer_skip_comments                = 1
let g:colorizer_syntax                       = 0
let g:Hexokinase_optInPatterns               = 'full_hex,triple_hex,rgb,rgba,hsl,hsla,colour_names'
let g:Hexokinase_highlighters                = ['backgroundfull']
let g:qs_highlight_on_keys                   = ['f', 'F', 't', 'T']
let g:vimwiki_list                           = [{'path': '~/vimwiki/', 'syntax': 'default', 'ext': '.wiki'}]
let g:vimwiki_global_ext                     = 0
let g:livepreview_previewer                  = 'zathura'
let g:bufferline_echo                        = 0
let g:slime_target                           = "tmux"
let g:slime_cell_delimiter                   = "#%%"
let vim_markdown_preview_browser             = 'firefox'
let asmsytnax                                = 'armasm'
let filetype_inc                             = 'armasm'
let vimclojure#FuzzyIndent                   = 4
let g:jedi#completions_enabled               = 1
let g:jedi#rename_command                    = "<leader>c"
let g:latex_to_unicode_auto                  = 1
let g:AutoClosePumvisible                    = {"ENTER": "<C-Y>", "ESC": "<ESC>"}
let g:closetag_filenames                     = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames               = '*.xhtml,*.jsx'
let g:closetag_filetypes                     = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes               = 'xhtml,jsx'
let g:closetag_emptyTags_caseSensitive       = 1
let g:closetag_regions                       = { 'typescript.tsx': 'jsxRegion,tsxRegion'
                                             \ , 'javascript.jsx': 'jsxRegion'
                                             \ , 'typescriptreact': 'jsxRegion,tsxRegion'
                                             \ , 'javascriptreact': 'jsxRegion'
                                             \ }
let g:closetag_shortcut                      = '>'
let g:closetag_close_shortcut                = '<leader>>'
let g:rainbow_active                         = 0
let g:rainbow_conf                           = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'guis': [''],
\   'cterms': [''],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'markdown': {
\           'parentheses_options': 'containedin=markdownCode contained',
\       },
\       'clojure': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'hy': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'haskell': 0,
\       'nerdtree': 0,
\       'vim': {
\           'parentheses_options': 'containedin=vimFuncBody',
\       },
\       'perl': {
\           'syn_name_prefix': 'perlBlockFoldRainbow',
\       },
\       'stylus': {
\           'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
\       },
\       'css': 0,
\   }
\}

" Mini Map
map <leader>mm :MinimapToggle<cr>

" ESKK
imap <Leader>j <Plug>(eskk:toggle)
cmap <Leader>j <Plug>(eskk:toggle)
lmap <Leader>j <Plug>(eskk:toggle)
set completeopt+=menuone

" Greek Variable Names
map <leader>$ :call Toggle_math_mode()<CR>a

" REPL vim
map <F11> :call CompileRun()<CR>
map <F12> :call InteractiveLoad()<CR>
nnoremap <silent> <leader>l :ReplSendLine<cr>
nnoremap <silent> <leader>r :ReplSendRegion<cr>
nnoremap <silent> <leader>R :ReplReloadFile<cr>

" Terminal
tnoremap <Esc> <C-\><C-n>

" Open Terminal
function OpenTerm()
    execute "belowright split"
    execute "resize -10"
    execute "term $SHELL"
    setlocal syntax=sh
    setlocal modifiable
    setlocal nonumber
    setlocal norelativenumber
    setlocal signcolumn=no
    setlocal nocursorline
    setlocal nocursorcolumn
    normal A
endfunction
map <F9> :call OpenTerm()<CR>

" Highlight 80th column
function ToggleColumnHighlight ()
    if &cc != 0
        set cc=0
    else
        set cc=80
    endif
endfunction
map <F8> :call ToggleColumnHighlight()<CR>

" Toggle Conceal Level
function! ToggleConcealLevel()
    if &conceallevel == 0
        setlocal conceallevel=2
    else
        setlocal conceallevel=0
    endif
endfunction
map <F7> :call ToggleConcealLevel()<CR>

" Lightline Dev Icons
function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction
function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" Spell check language
setlocal spell spelllang=en_us
nnoremap <silent> <leader>s :set spell!<cr>

" Quick save
nmap W :w<CR>

" COC
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes

inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : "\<TAB>"
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

if has('patch8.1.1068')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Telescope
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Search
"lua << EOF
"require('animated-search-highlight').setup({
"  fg1 = "#0E0E0E",
"  fg2 = "#000000",
"  bg1 = "#E0E0E0",
"  bg2 = "#FFFFFF",
"})
"EOF

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Increment Decrement Numbers
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

" Buffers
nnoremap <silent> <C-N> :bnext<CR>
nnoremap <silent> <C-P> :bprev<CR>
nnoremap <silent> <C-U> :Unite file buffer<CR>
"nnoremap <silent> <C-F> :CHADopen<CR>
nnoremap <leader>f :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
nnoremap <C-f> :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFind<CR>

" Move to Split
"nnoremap <silent> <c-k> :wincmd k<CR>
"nnoremap <silent> <c-j> :wincmd j<CR>
"nnoremap <silent> <c-h> :wincmd h<CR>
"nnoremap <silent> <c-l> :wincmd l<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Size Split
nnoremap <silent> <c-up> :res -2<CR>
nnoremap <silent> <c-down> :res +2<CR>
nnoremap <silent> <c-right> :vertical res +2<CR>
nnoremap <silent> <c-left> :vertical res -2<CR>

" APL Character Picker
set wildcharm=<C-Z>
map <leader>2 :emenu APL.<C-Z>

" German special characters: ä, ö, ü, ß
function MapGermanCharacters()
    if &filetype == "nroff"
        imap \ae \[:a]
        imap \oe \[:o]
        imap \ue \[:u]
        imap \Ae \[:A]
        imap \Oe \[:O]
        imap \Ue \[:U]
        imap \ss \[ss]
    elseif &filetype == "latex"
        imap \ae {\"a}
        imap \oe {\"o}
        imap \ue {\"u}
        imap \Ae {\"A}
        imap \Oe {\"O}
        imap \Ue {\"U}
        imap \ss {\ss}
    else
        imap \ae ä
        imap \oe ö
        imap \ue ü
        imap \Ae Ä
        imap \Oe Ö
        imap \Ue Ü
        imap \ss ß
    endif
endfunction
command! SetGermanCharacters call MapGermanCharacters()

" Personal Preferences
"set completeopt=longest,menu,preview
set tabstop=4
set shiftwidth=4
set expandtab
set number relativenumber
set cursorline
set cursorcolumn
set nospell
set clipboard+=unnamedplus
set encoding=utf-8
set conceallevel=2

set foldmethod=syntax
set foldlevel=999999

"let g:clipboard = {
"        \   'name': 'xsel - bin',
"        \   'copy': {
"        \      '+': '/usr/bin/xsel -i -b',
"        \      '*': '/usr/bin/xsel -i -p',
"        \    },
"        \   'paste': {
"        \      '+': '/usr/bin/xsel -b',
"        \      '*': '/usr/bin/xsel -p',
"        \   },
"        \   'cache_enabled': 0,
"\ }

"set autoindent
"set smartindent
"set updatecount=1000

" Colorpicker
noremap <leader>cp :r!colorpicker --one-shot --short +\%c<CR>

" Nabla
nnoremap <F10> :lua require("nabla").place_inline()<CR>

" Magma
nnoremap <silent><expr> <LocalLeader>j  :MagmaEvaluateOperator<CR>
nnoremap <silent>       <LocalLeader>jl :MagmaEvaluateLine<CR>
xnoremap <silent>       <LocalLeader>j  :<C-u>MagmaEvaluateVisual<CR>
nnoremap <silent>       <LocalLeader>jr :MagmaReevaluateCell<CR>
nnoremap <silent>       <LocalLeader>jd :MagmaDelete<CR>
nnoremap <silent>       <LocalLeader>jo :MagmaShowOutput<CR>

" Buffer close
noremap <leader>b :Bclose<CR>

" Easy Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Disable Arrow keys in Normal mode
noremap <up>    <nop>
noremap <down>  <nop>
noremap <left>  <nop>
noremap <right> <nop>

" Disable Arrow keys in Insert mode
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" Disable Arrow keys in Insert mode
vnoremap <up>    <nop>
vnoremap <down>  <nop>
vnoremap <left>  <nop>
vnoremap <right> <nop>

" Colorscheme
syntax on
colorscheme komau
set background=dark

" Mail
if &filetype == "mail"
    set spell
    SetGermanCharacters
endif

" Remote SSH
"lua << EOF
"    require('remote-sshfs').setup({})
"    require('telescope').load_extension 'remote-sshfs'
"EOF

lua << EOF
    require('xbase').setup({})
EOF

" NeoVide
set guifont=GoMono\ Nerd\ Font\ Mono:h14    " specify font and size
let g:neovide_refresh_rate                 = 144       " refresh rate of gfx window
let g:neovide_transparency                 = 1.0       " window background opacity
let g:neovide_no_idle                      = v:false   " immediately redraw
let g:neovide_fullscreen                   = v:false   " borderless windowed full screen
let g:neovide_cursor_vfx_mode              = "railgun" " cursor animation style [railgun|torpedo|pixiedust|sonicboom|ripple|wireframe]
let g:neovide_cursor_animation_length      = 0.1       " cursor animation time in ms
let g:neovide_cursor_trail_length          = 0.1       " cursor trail length during animation
let g:neovide_cursor_antialiasing          = v:true    " cursor animation antialising
let g:neovide_cursor_vfx_opacity           = 200.0     " transparency of particle effects
let g:neovide_cursor_vfx_particle_lifetime = 1.2       " duration of particle effects in s
let g:neovide_cursor_vfx_particle_density  = 7.0       " density of particle effects
let g:neovide_cursor_vfx_particle_speed    = 10.0      " velocity of particle effects
let g:neovide_cursor_vfx_particle_phase    = 1.5       " ?
let g:neovide_cursor_vfx_particle_curl     = 1.0       " ?

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
