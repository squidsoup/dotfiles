"	General Settings
set nocompatible
set encoding=utf-8
set runtimepath=~/.vim,~/.vim/vim-plugin-manager,$VIMRUNTIME
let vimfiles=$HOME . "/.vim"
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
set autoindent smartindent
set ts=2
set shiftwidth=2
set expandtab
set sw=2

" Java Classpath
let sep=":"
let classpath = join(
   \[".",
   \ "src", "src/main/clojure", "src/main/resources",
   \ "test", "src/test/clojure", "src/test/resources",
   \ "classes", "target/classes",
   \ "lib/*", "lib/dev/*",
   \ "bin",
   \ vimfiles."/lib/*"
   \],
   \ sep)

" Syntax
syntax on
filetype plugin on
filetype indent on

" Backup
set nobackup
set nowritebackup

" Statusline
set laststatus=2
set showcmd
let g:Powerline_symbols = 'fancy'

" supertab
 
" mvim settings
colorscheme molokai
if has('gui_running')
	set guioptions-=m "remove menu bar
	set guioptions-=T "remove toolbar
	set guioptions-=r "remove scrollbar
	set guifont=Mensch\ for\ Powerline:h14
endif

"	Menu Completion
set wildmode=longest,list,full
set wildmenu
set infercase
set wildignore+=*.o,*.obj,*.pyc,*.DS_STORE,*.db

"	Keybindings
noremap <space> :
let mapleader=","
map <silent> <Left> :call ToggleVExplorer()<CR>

" File Explorer
let g:netrw_liststyle=3 " Use tree-mode as default view
let g:netrw_browse_split=4 " Open file in previous buffer
let g:netrw_preview=1 " preview window shown in a vertically split

" Init pathogen
call pathogen#infect()
call pathogen#helptags()

" Command-T
" flush on vim window focus and file write
augroup CommandTExtension
  autocmd!
  autocmd FocusGained * CommandTFlush
  autocmd BufWritePost * CommandTFlush
augroup END

" Ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd BufRead,BufNewFile *.erb set filetype=eruby.html

"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

" CoffeeScript
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab 
" autocompile
au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!

" Jinja
au BufNewFile,BufReadPost *.jinja2 set ft=htmljinja.vim

" VimClojure
let vimclojureRoot = vimfiles."/bundle/VimClojure"
let vimclojure#HighlightBuiltins = 1
let vimclojure#HighlightContrib = 1
let vimclojure#DynamicHighlighting = 1
let vimclojure#ParenRainbow = 1
let vimclojure#WantNailgun = 1
let vimclojure#NailgunClient = vimclojureRoot."/lib/nailgun/ng"

" LaTeX settings
let g:tex_flavor='latex'
set iskeyword+=:
set grepprg=grep\ -nH\ $*

" Syntastic 
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
nnoremap <silent> ` :Errors<CR>

" Functions
" Toggle Vexplore
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
