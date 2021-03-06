set nocompatible

execute pathogen#infect()

" Match ruby do / end
runtime macros/matchit.vim
source ~/.vim/osc52.vim

au BufWritePost .vimrc so $MYVIMRC

filetype plugin on
filetype indent plugin on
syntax on

set ignorecase
set smartcase

set ruler
set hlsearch

" Line numbers
"set number
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
inoremap jj <esc>
map <F1> <esc>
imap <F1> <esc>

call plug#begin('~/.vim/plugged')

set runtimepath^=~/.vim/bundle/ctrlp.vim
set tags=.git/tags

vmap <C-c> y:call SendViaOSC52(getreg('"'))<cr>

function! SubDataReplace()
  %s/submission.borrower.employment_summary.\(\w\+\)/submission_data['\1']/
  %s/submission.borrower.current_address\.\(\w\+\)/submission_data['address_\1']/
  %s/submission.borrower.\(\w\+\)/submission_data['\1']/
  %s/submission\.uuid/submission_data['submission_uuid']/
  %s/submission\.\(\w\+\)/submission_data['\1']/
endfunction
