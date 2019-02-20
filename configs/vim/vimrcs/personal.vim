let mapleader = "\<SPACE>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Install vim-plug
""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins
""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" Visual
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'machakann/vim-highlightedyank'
Plug 'Yggdroot/indentLine'

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Development Environment
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'

" Python
Plug 'ncm2/ncm2-jedi'
Plug 'ambv/black'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" onedark.vim
""""""""""""""""""""""""""""""""""""""""
set termguicolors
colorscheme onedark

" vim-airline
""""""""""""""""""""""""""""""""""""""""
let g:airline_theme = 'onedark'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1

" nerdtree
""""""""""""""""""""""""""""""""""""""""
let NERDTreeQuitOnOpen = 0
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" automatically open and close
autocmd vimenter * NERDTree | wincmd p
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Editor
""""""""""""""""""""""""""""""""""""""""
" ale
let g:ale_linters = { 'python': ['flake8', 'mypy', 'pyls'] }
let g:ale_linters_ignore = { 'python': ['pyls'] }
let g:ale_fixers = { 'python': ['black', 'isort', 'trim_whitespace', 'autopep8'] }
let g:ale_fix_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_python_flake8_options = '--max-line-length 120'

" black
let g:python_black_options = '--line-length=120 --skip-string-normalization'
let g:black_linelength = 120
let g:black_skip_string_normalization = 1

" ncm2
autocmd BufEnter  *  call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" language client
set hidden
let g:LanguageClient_serverCommands = { 'python': ['pyls'] }

" Python
""""""""""""""""""""""""""""""""""""""""
let g:loaded_python_provider = 1
let g:python3_host_prog = '/usr/local/bin/python3'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Base Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General
""""""""""""""""""""""""""""""""""""""""
set mouse=a                     " Allow mouse clicking
set ruler                       " Show the column number on status
set number                      " Show line number on the side
set cursorline                  " Show the current line
set showmatch                   " Highlight matching parens/brackets
set scrolloff=3                 " Keep cursor 3 lines away from screen border

" Clipboad
set clipboard^=unnamed,unnamedplus

" Tabbing
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Ignore case on search unless caps in query
set ignorecase
set smartcase

" Split panes to the right and bottom
set splitbelow
set splitright

" Directories for swp files
set nobackup
set noswapfile

" Draw line at length 80
highlight ColorColumn ctermbg=gray
set colorcolumn=120

" Italicise comments
highlight Comment cterm=italic

" Highlight trailing whitespace characters
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set list
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\|\t/


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" FZP find
nmap <leader>f :GFiles<CR>
nmap <leader>F :Files<CR>

" LanguageClient
nnoremap <silent> <leader>d :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>n :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <leader>r :call LanguageClient#textDocument_rename()<CR>

" Create parent folders recursively
cnoremap mk. !mkdir -p %:h


