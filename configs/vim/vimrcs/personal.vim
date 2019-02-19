"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Base Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General
""""""""""""""""""""""""""""""""""""""""
set ruler                       " Show the column number on status
set number                      " Show line number on the side
set showmatch                   " Highlight matching parens/brackets
set scrolloff=3                 " Keep cursor 3 lines away from screen border

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

" Use space as leader
let mapleader = "\<Space>"

" Create parent folders recursively
cnoremap mk. !mkdir -p %:h


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

" General
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'machakann/vim-highlightedyank'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale'

" Python
Plug 'davidhalter/jedi-vim'
Plug 'klen/python-mode'
Plug 'ambv/black'
Plug 'fisadev/vim-isort'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-airline
""""""""""""""""""""""""""""""""""""""""
let g:airline_theme = 'powerlineish'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1

" nerdtree
""""""""""""""""""""""""""""""""""""""""
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" automatically open and close
autocmd vimenter * NERDTree | wincmd p
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Python
""""""""""""""""""""""""""""""""""""""""
let g:loaded_python_provider = 1
let g:python3_host_prog = '/usr/local/bin/python3'

" python-mode
let g:pymode_folding = 0
let g:pymode_lint = 0
let g:pymode_motion = 0
let g:pymode_options_colorcolumn = 0
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_run_bind = ''
let g:pymode_python = 'python3'

" autoformat
augroup PythonAutoFormat
  autocmd!
  if filereadable('.black')
    autocmd BufWritePre *.py execute ':Isort'
    autocmd BufWritePre *.py execute ':silent Black'
  endif
augroup END

" jedi
let g:jedi#completions_enabled = 0
let g:jedi#rename_command = ''
