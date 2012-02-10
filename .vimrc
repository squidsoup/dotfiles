set runtimepath=~/.vim,~/.vim/vim-plugin-manager,$VIMRUNTIME
set ruler
set number
set cursorline
set vb
set ttyfast
set titlestring=%f title
set showcmd
set splitbelow
"set foldcolumn=3
"set foldmethod=syntax
"set foldlevelstart=99

"	General Settings
syntax on
filetype plugin on
filetype indent on
set autoindent smartindent
set ts=2
set shiftwidth=2
set sw=2

" Backup
set nobackup
set nowritebackup

" statusline
set laststatus=2
set showcmd

" mvim settings
colorscheme molokai
if has('gui_running')
	set guioptions-=m "remove menu bar
	set guioptions-=T "remove toolbar
	set guioptions-=r "remove scrollbar
	set guifont=Monaco:h13
endif

" CoffeeScript
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab 
" 	autocompile
au BufWritePost *.coffee silent CoffeeMake!

" LaTeX settings
let g:tex_flavor='latex'
set iskeyword+=:
set grepprg=grep\ -nH\ $*
"	Menu Completion
set wildmode=longest,list,full
set wildmenu
set infercase
set wildignore+=*.o,*.obj,*.pyc,*.DS_STORE,*.db

"	Keybindings
noremap <space> :

" Syntastic 
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
nnoremap <silent> ` :Errors<CR>

" Init pathogen
call pathogen#infect()
call pathogen#helptags()
