" Environmnet {
  set nocompatible
  filetype off
  set encoding=utf-8
  set background=dark
  set runtimepath=~/.vim,~/.vim/vim-plugin-manager,$VIMRUNTIME,$GOROOT/misc/vim
  set viminfo+=!
  let vimfiles=$HOME . "/.vim"

  " Init vundle {
    set rtp+=~/.vim/bundle/vundle 
    call vundle#rc()
    Bundle 'gmarik/vundle'
  " }

  " Bundles {
    Bundle 'tpope/vim-classpath'
    Bundle 'guns/vim-clojure-static'
    Bundle 'tpope/vim-fireplace'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-rails'
    Bundle 'tpope/vim-endwise'
    Bundle 'Lokaltog/vim-powerline'
    Bundle 'vim-ruby/vim-ruby'
    Bundle 'scrooloose/syntastic'
    Bundle 'jpalardy/vim-slime'
    Bundle 'kien/ctrlp.vim'
    Bundle 'avakhov/vim-yaml'
    Bundle 'othree/html5.vim'
    Bundle 'wting/rust.vim'
  "}

" }

"	General {
  " Syntax {
    syntax on
    filetype plugin indent on
  " }

  " File Explorer {
    let g:netrw_liststyle=3 " Use tree-mode as default view
    let g:netrw_browse_split=4 " Open file in previous buffer
    let g:netrw_preview=1 " preview window shown in a vertically split
  " }

  " Backup  {
    set nobackup
    set nowritebackup
  " }
"}

" Vim UI {
  set ruler
  set number
  set showcmd
  set splitbelow
  set t_vb=
  set ttyfast
  set titlestring=%f title
  set cursorline
  highlight Pmenu ctermbg=238 gui=bold

  " Statusline {
    set laststatus=2
    set showcmd
    let g:Powerline_symbols = 'fancy'

    if ! has('gui_running')
      set ttimeoutlen=10
      augroup FastEscape
          autocmd!
          au InsertEnter * set timeoutlen=0
          au InsertLeave * set timeoutlen=1000
      augroup END
    endif
  " }

  "	Menu Completion {
    set wildmode=longest,list,full
    set wildmenu
    set infercase
    set wildignore+=*.o,*.obj,*.pyc,*.DS_STORE,*.db,*/tmp/*,*/vendor/*
  " }
  
  " Control-P {
    let g:ctrlp_working_path_mode = 0 
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git|\.hg|target|build',
      \ 'file': '\.class$\|\.min.js$'
      \ }
  " }

  " vim-slim {
    let g:slime_target = "tmux"
  " }

  " gui/mvim settings {
    colorscheme molokai
    if has('gui_running')
      set guioptions-=m "remove menu bar
      set guioptions-=T "remove toolbar
      set guioptions-=r "remove scrollbar
      if has("gui_gtk2")
        set guifont=Mensch\ for\ Powerline\ 11
      else
        set guifont=Mensch\ for\ Powerline:h14
      endif
      set t_vb=
    endif
  " }

  " Searching {
    set hlsearch " hilight matches 
    set incsearch " incremental searching 
    set ignorecase " searches are case insensitive...
    set smartcase " ...unless containing at least one capital letter
  " }
" }

" Formatting {
  set autoindent smartindent
  set tabstop=2
  set shiftwidth=2
  set expandtab
" }

"	Keybindings {
  noremap <space> :
  let mapleader=","
  map <silent> <Left> :call ToggleVExplorer()<CR>
" }

" Lang {
  " Python {
    au BufNewFile,BufReadPost *.py setl shiftwidth=4 expandtab 
    highlight BadWhitespace ctermbg=red guibg=red 
    au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
    au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
  " }
  
  " Golang {
    "set runtimepath+=$GOROOT/misc/vim
    autocmd BufWritePost *.go :silent Fmt
  " }

  " Java {
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
  " }

  " Ruby {
    autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
    autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
    autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
    autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
    autocmd BufRead,BufNewFile *.erb set filetype=eruby.html
  " }

  " CoffeeScript {
    au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab 
    au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw! " autocompile
  " }

  " Jinja {
    au BufNewFile,BufReadPost *.jinja2 set ft=htmljinja.vim
  " }

  " LaTeX {
    let g:tex_flavor='latex'
    set iskeyword+=:
    set grepprg=grep\ -nH\ $*
  " }

  " Markdown {
    au BufNewFile,BufRead *.md setlocal ft=markdown
  " }
" }

" Plugins {
  " Syntastic {
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=0
    let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
    let g:syntastic_python_checkers=['flake8']
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    nnoremap <silent> ` :Errors<CR>
  " }

" }

" Functions {
  function! ToggleVExplorer() " Toggle Vexplore
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

  " MULTIPURPOSE TAB KEY
  " from: https://raw.github.com/garybernhardt/dotfiles/master/.vimrc
  " Indent if we're at the beginning of a line. Else, do completion.
  function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
      return "\<tab>"
    else
      return "\<c-p>"
    endif
  endfunction
  inoremap <tab> <c-r>=InsertTabWrapper()<cr>
  inoremap <s-tab> <c-n>
" }
