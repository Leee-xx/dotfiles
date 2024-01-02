set nocompatible
set re=2

execute pathogen#infect()

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2

" Match ruby do / end
runtime macros/matchit.vim

au BufWritePost .vimrc so $MYVIMRC

filetype plugin on
filetype indent plugin on
syntax on

set ignorecase
set smartcase

set ruler
set hlsearch

" Line numbers
" Set hybrid line numbers
set number relativenumber

set laststatus=2

" Nerdtree settings
let NERDTreeShowHidden=1

"set mouse=a

" Tabs
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

set bs=2

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

set pastetoggle=<F11>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" split pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Uses _ instead of - to make holding down shift easier
nnoremap _ :resize -5<CR>
nnoremap + :resize +5<CR>

nnoremap <C-G> :w<CR>

" tabbed window navigation
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" Use CTRL+n to toggle NERDTree navigation pane
map <C-n> :NERDTreeToggle<CR>
nmap ,n :NERDTreeFind<CR>

" remap ctrl-s to save - doesn't work yet
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Deal with stupid macbook touchbar
inoremap kj <esc>
map <F1> <esc>
imap <F1> <esc>

" https://vim.fandom.com/wiki/Copy_filename_to_clipboard
"nmap ,cs :let @*=expand("%")<CR>
"nmap ,cl :let @*=expand("%:p")<CR>
nmap ,cl :let @*=expand("%")<CR>
nmap ,cr :let @*=expand("%t")<CR>
nmap ,cd :let @*=expand("%:p:h")<CR>

" Fugitive shortcuts
nmap ,gb :Git blame %<CR>
nmap ,ga :Git add %<CR>
nmap ,go :Gread<CR>
nmap ,gd :G diff %<CR>

" Ruby
nmap ,rB :!bundle exec rubocop -a %<CR>
nmap ,rc :!ruby -c %<CR>

nmap ,js :%!jq .<CR>

call plug#begin()
  Plug '~/.vim/plugged'
  Plug 'pangloss/vim-javascript'
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'preservim/nerdtree'
  Plug 'ojroques/vim-oscyank', {'branch': 'main'}
  Plug 'chrisbra/csv.vim'
call plug#end()

set runtimepath^=~/.vim/bundle/ctrlp.vim
set tags=.git/tags

vmap <C-c> y:OSCYankVisual<cr>
