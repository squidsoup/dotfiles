" Environmnet {
  set nocompatible
  filetype off
  set encoding=utf-8
  set background=dark
  set runtimepath=~/.vim,~/.vim/vim-plugin-manager,$VIMRUNTIME
  let vimfiles=$HOME . "/.vim"

  " Init vundle {
    set rtp+=~/.vim/bundle/vundle 
    call vundle#rc()
    Bundle 'gmarik/vundle'
  " }

  " Bundles {
    Bundle 'tpope/vim-rails'
    Bundle 'tpope/vim-endwise'
    Bundle 'Lokaltog/vim-powerline'
    Bundle 'vim-ruby/vim-ruby'
    Bundle 'scrooloose/syntastic'
    Bundle 'vim-scripts/VimClojure'
    Bundle 'jpalardy/vim-slime'
    Bundle 'git://git.wincent.com/command-t.git'
  "}

" }

"	General {
  " Syntax {
    syntax on
    filetype plugin on
    filetype indent on
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
  set vb
  set ttyfast
  set titlestring=%f title
  set cursorline
  highlight Pmenu ctermbg=238 gui=bold

  " Statusline {
    set laststatus=2
    set showcmd
    let g:Powerline_symbols = 'fancy'
  " }

  "	Menu Completion {
    set wildmode=longest,list,full
    set wildmenu
    set infercase
    set wildignore+=*.o,*.obj,*.pyc,*.DS_STORE,*.db
  " }

  " gui/mvim settings {
    colorscheme molokai
    "if has('gui_running')
      set guioptions-=m "remove menu bar
      set guioptions-=T "remove toolbar
      set guioptions-=r "remove scrollbar
      set guifont=Mensch\ for\ Powerline:h14
    "endif
  " }
" }

" Formatting {
  set autoindent smartindent
  set ts=2
  set shiftwidth=2
  set expandtab
  set sw=2
" }

"	Keybindings {
  noremap <space> :
  let mapleader=","
  map <silent> <Left> :call ToggleVExplorer()<CR>
" }

" Lang {
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
" }

" Plugins {
  " Syntastic {
    let g:syntastic_enable_signs=1
    let g:syntastic_auto_loc_list=0
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    nnoremap <silent> ` :Errors<CR>
  " }

  " VimClojure {
    let vimclojureRoot = vimfiles."/bundle/VimClojure"
    let vimclojure#HighlightBuiltins = 1
    let vimclojure#HighlightContrib = 1
    let vimclojure#DynamicHighlighting = 1
    let vimclojure#ParenRainbow = 1
  " }

  " Command-T {
    augroup CommandTExtension " flush on vim window focus and file write
      autocmd!
      autocmd FocusGained * CommandTFlush
      autocmd BufWritePost * CommandTFlush
    augroup END
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
" }
