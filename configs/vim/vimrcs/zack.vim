let mapleader = "\<Space>"         " Use space as leader

" Legacy settings.
if !has('nvim')
    set ai                         " auto indenting
    set autoread                   " reread file on focus
    set backspace=indent,eol,start " backspace over everything in insert mode
    set encoding=utf-8             " Set the default encodings just in case $LANG isn't set
    set laststatus=2               " grey status bar at the bottom
    set smarttab                   " be smart when using tabs
    set termencoding=utf-8         " Set the default encodings just in case $LANG isn't set
    set ttymouse=xterm2            " more mouse
    syntax enable                  " syntax highlighting
endif

set colorcolumn=80                 " line length matters
set foldmethod=manual              " set a foldmethod
set hidden
set mouse=a                        " enable mouse
set number                         " line numbers
set scrolloff=2                    " Always shows two lines of vertical context around the cursor
set showcmd                        " show incomplete commands

set hlsearch                       " highlight what you search for
set ic                             " case insensitive search
set incsearch                      " type-ahead-find
set scs                            " smart case search

set expandtab                      " use spaces instead of tabs
set shiftwidth=4                   " 1 tab == 2 spaces
set tabstop=4                      " 1 tab == 2 spaces

set splitbelow                     " all horizontal splits open to the bottom
set splitright                     " all vertical splits open to the right

set nobackup                       " no backup files
set noswapfile                     " no swap files
set nowritebackup                  " only in case you don't want a backup file while editing

" Restrict CursorLine to active window.
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * highlight CursorLineNr ctermfg=3
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Copy to system clipboard.
vnoremap <Leader>y "+y

" Double slash to search for visual selection.
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnorem // y/<c-r>"<cr>

" Indentation.
filetype plugin indent on
autocmd Filetype bash       setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby       setlocal ts=2 sts=2 sw=2
autocmd Filetype sh         setlocal ts=2 sts=2 sw=2
autocmd Filetype vim        setlocal ts=2 sts=2 sw=2
autocmd Filetype xml        setlocal ts=2 sts=2 sw=2
autocmd Filetype yaml       setlocal ts=2 sts=2 sw=2
autocmd Filetype zsh        setlocal ts=2 sts=2 sw=2

" Python 79 lines.
autocmd Filetype python setlocal textwidth=79

" *.pyi stub files.
au BufNewFile,BufRead *.pyi setfiletype python

" Detect tmux.conf, must be before *.conf.
au BufNewFile,BufRead {.,}tmux*.conf* setfiletype tmux

" Detect ini files.
au BufNewFile,BufRead *.ini,*.conf setf dosini

" Vagrantfile syntax highlighting.
au BufNewFile,BufRead Vagrantfile set filetype=ruby

" Window navigation.
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> :<C-u>TmuxNavigateLeft<CR>
nmap <C-l> <C-w>l

" Move by screen lines.
noremap j gj
noremap k gk

" Filter command history.
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Bootstrap vim-plug.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
if $BACKGROUND == "light"
  let g:airline_theme                         = 'solarized'
else
  let g:airline_theme                         = 'onedark'
endif
let g:airline_left_sep                        = ''
let g:airline_right_sep                       = ''
let g:airline_section_y                       = ''
let g:airline#extensions#tabline#enabled      = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#branch#enabled       = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto pairs.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'jiangmiao/auto-pairs'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
let g:deoplete#enable_at_startup = 1
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/Users/zhsi/.pyenv/versions/3.6.1/bin/python3.6'
" Use shift to cycle through completions.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
let g:deoplete#sources#jedi#show_docstring = 1
" New line when the typed word matches the suggestion exactly and I hit enter.
inoremap <silent><expr><CR> pumvisible() ? deoplete#mappings#close_popup()."\<CR>" : "\<CR>"
" Close preview window upon completion.
autocmd CompleteDone * pclose!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitive.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'

" Redefine :Ag command
function! s:ag_with_opts(arg, bang)
  let tokens  = split(a:arg)
  let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
  let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
  call fzf#vim#ag(query, ag_opts, a:bang ? {} : {'down': '40%'})
endfunction

autocmd VimEnter * command! -nargs=* -bang Ag call s:ag_with_opts(<q-args>, <bang>0)

" Set fzf statusline color
function! s:fzf_statusline()
  highlight fzf1 ctermfg=yellow
  highlight fzf2 ctermfg=yellow
  highlight fzf3 ctermfg=yellow
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

noremap <silent> <Leader><Leader> :silent FZF <CR>
" Search word under cursor by using Ag | leader + a
noremap <silent> <leader>a :silent Ag <C-r>=expand('<cword>')<CR><CR>

" Search tags in buffer by using leader + t
noremap <silent> <leader>t :silent BTags<CR>

" Search all tags by using leader + T
noremap <silent> <leader>T :silent Tags<CR>

" Search marks by using leader + m
noremap <silent> <leader>m :silent Marks<CR>

function! BufList()
    redir => ls
    silent ls
    redir END
    return split(ls, '\n')
endfunction

function! BufOpen(e)
    execute 'buffer '. matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :silent call fzf#run({
\   'source':      reverse(BufList()),
\   'sink':        function('BufOpen'),
\   'options':     '+m',
\   'tmux_height': '40%'
\ })<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git gutter.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'airblade/vim-gitgutter'
highlight clear SignColumn

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gutentags.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'ludovicchabant/vim-gutentags'
noremap <Leader>c :GutentagsUpdate!<CR>
let g:gutentags_generate_on_empty_buffer = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JSX.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Multiple cursors.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'terryma/vim-multiple-cursors'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neomake.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'neomake/neomake', { 'dir': '~/oss/neomake' }
autocmd BufWritePost,BufEnter * Neomake

let g:neomake_java_enabled_makers = []
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_python_enabled_makers = ['flake8', 'pylint', 'mypy']
let g:neomake_highlight_columns = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree'
:command NT NERDTreeToggle
:command NTF NERDTreeFind
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeShowHidden=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Onedark.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'joshdick/onedark.vim'
let g:onedark_termcolors=16

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'klen/python-mode'
let g:pymode_folding = 0
let g:pymode_lint = 0
let g:pymode_motion = 0
let g:pymode_options_colorcolumn = 0
let g:pymode_rope = 0
let g:pymode_rope_completion = 0

Plug 'fisadev/vim-isort'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Repeat.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-repeat'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rust.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1
let g:racer_experimental_completer = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Solarized.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'altercation/vim-colors-solarized'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Surround.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-surround'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabular.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'godlygeek/tabular'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'majutsushi/tagbar'
:command TT TagbarToggle

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tcomment.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tomtom/tcomment_vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terraform
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'hashivim/vim-terraform'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tmux.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'christoomey/vim-tmux-navigator'
Plug 'sjl/vitality.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unimpaired.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-unimpaired'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Languages (non-Python).
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'bfontaine/Brewfile.vim'
Plug 'burnettk/vim-angular'
Plug 'cespare/vim-toml'
Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
Plug 'evanmiller/nginx-vim-syntax'
Plug 'fatih/vim-go'
Plug 'keith/swift.vim'
Plug 'keith/tmux.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'pangloss/vim-javascript'
Plug 'saltstack/salt-vim'

call plug#end()

if $BACKGROUND == "light"
  colorscheme solarized
else
  colorscheme onedark
endif

" Italic comments.
highlight Comment cterm=italic

" Highlight trailing whitespace red. Must be after colorscheme.
" http://stackoverflow.com/questions/4617059/showing-trailing-spaces-in-vim
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

