call plug#begin($HOME.'/.local/share/nvim/plugged')
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 Plug 'preservim/nerdtree'                                " Plugin for a file tree explorer
 Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
 Plug 'tiagofumo/vim-nerdtree-syntax-highlight'          " Plugin for syntax highlight tree explorer
 Plug 'ryanoasis/vim-devicons'                            " Plugin for adding icons to filetypes in NERDTree
 Plug 'Xuyuanp/nerdtree-git-plugin'
 Plug 'm4xshen/smartcolumn.nvim'                          " Plugin for aligning text in columns
 Plug 'neoclide/coc.nvim', {'branch': 'release'}          " Plugin for autocompletion and language server protocol
 Plug 'nvim-lua/plenary.nvim'                             " Plugin :telescope dependency
 Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' } " Plugin for fuzzy searching and file navigation
 Plug 'hashivim/vim-terraform', { 'for': 'terraform' }    " Plugin for terraform
 Plug 'lewis6991/gitsigns.nvim'
 Plug 'kdheepak/lazygit.nvim'
 Plug 'mg979/vim-visual-multi', {'branch': 'master'}
 Plug 'preservim/nerdcommenter'
 Plug 'itchyny/lightline.vim'
 Plug 'itchyny/vim-gitbranch'
 Plug 'kylechui/nvim-surround' 
 Plug 'nvim-treesitter/nvim-treesitter-textobjects'
 Plug 'rmagatti/auto-session'
 Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
 Plug 'mechatroner/rainbow_csv'
 Plug 'RRethy/vim-illuminate'
call plug#end()

let mapleader=" "
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number relativenumber   " add line numbers
set nu rnu
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
set encoding=utf-8
set cursorline              " highlight current cursorline
set noswapfile
set nowrap
set sidescrolloff=110
set scrolloff=5

colorscheme tokyonight-storm


let g:coc_global_extensions = [
  \ 'coc-pyright',
  \ 'coc-diagnostic',
  \ 'coc-html',
  \ 'coc-yaml',
  \ 'coc-spell-checker',
  \ 'coc-pairs',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-markdownlint',
  \ ]

let g:NERDTreeGitStatusIndicatorMapCustom = {
  \ 'Modified'  :'✹',
  \ 'Staged'    :'✚',
  \ 'Untracked' :'✭',
  \ 'Renamed'   :'➜',
  \ 'Unmerged'  :'═',
  \ 'Deleted'   :'✖',
  \ 'Dirty'     :'✗',
  \ 'Ignored'   :'☒',
  \ 'Clean'     :'✔︎',
  \ 'Unknown'   :'?',
  \ }

let NERDTreeShowHidden=1
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeGitStatusUntrackedFilesMode = 'all'
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'filename': 'LightlineFilename',
      \ },
      \ }
function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:F') !=# '' ? expand('%:F') : '[No Name]'
endfunction
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

command! -nargs=0 MdFmt :CocCommand markdownlint.fixAll
command! -nargs=0 JustFmt :!just --fmt --unstable

autocmd BufWritePre *.md :silent !MdFmt %
autocmd BufWritePre Justfile :silent !JustFmt %
autocmd BufWritePre *.py  :silent call CocAction('runCommand', 'editor.action.organizeImport')

nmap <silent><leader>d <Plug>(coc-definition)
nmap <silent><leader>w  <Plug>(coc-type-definition)
nmap <silent><leader>i <Plug>(coc-implementation)
nmap <silent><leader>r <Plug>(coc-references)
nmap <silent><leader>e <Plug>(coc-rename)

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fr <cmd>Telescope resume<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


nnoremap <silent> <leader>gg :LazyGit<CR>

nnoremap <leader>nt <cmd>NERDTreeToggle<CR>

let NERDTreeIgnore = ['\.mypy_cache', '\.pytest_cache', '\.vscode', '__pycache__']

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "python", "json" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF

lua << EOF
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}
EOF

lua << EOF
require("nvim-surround").setup{}
require("toggleterm").setup()
EOF

lua << EOF
require("auto-session").setup {
  log_level = "error",

  cwd_change_handling = {
    restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
    pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
    post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
      require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
    end,
  },
}
EOF
