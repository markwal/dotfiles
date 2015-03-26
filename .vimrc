" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" auto preview window on current hover word, taken from :help ptag
au! CursorHold *.[ch] nested call PreviewWord()
func PreviewWord()
  if &previewwindow			" don't do this in the preview window
    return
  endif
  let w = expand("<cword>")		" get the word under cursor
  if w =~ '\a'			" if the word contains a letter

    " Delete any existing highlight before showing another tag
    silent! wincmd P			" jump to preview window
    if &previewwindow			" if we really get there...
      match none			" delete existing highlight
      wincmd p			" back to old window
    endif

    " Try displaying a matching tag for the word under the cursor
    try
       exe "ptag " . w
    catch
      return
    endtry

    silent! wincmd P			" jump to preview window
    if &previewwindow		" if we really get there...
	 if has("folding")
	   silent! .foldopen		" don't want a closed fold
	 endif
	 call search("$", "b")		" to end of previous line
	 let w = substitute(w, '\\', '\\\\', "")
	 call search('\<\V' . w . '\>')	" position cursor on match
	 " Add a match highlight to the word at this position
      hi previewWord term=bold ctermbg=green guibg=green
	 exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
      wincmd p			" back to old window
    endif
  endif
endfun

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" font
set gfn=Consolas:h9:cANSI

set colorcolumn=80

"bigger gui windows
if has("gui_running")
    set lines=66
    set columns=100
endif

" tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" all the vim backups in one place
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" plug.vim from https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-scripts/CycleColor'
Plug 'vim-scripts/netrw.vim'
Plug 'kien/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'ciaranm/DetectIndent', { 'on': 'DetectIndent' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'yuratomo/dbg.vim', { 'on': 'Dbg' }
Plug 'tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-unimpaired.git'
Plug 'tpope/vim-surround'
" Plug 'simplyzhao/cscope_maps.vim'
call plug#end()

" some custom key mappings
noremap <Leader> <Plug>(easymotion-prefix)
nnoremap <F8> :TagbarToggle<CR>
noremap <c-p> :CtrlP<CR>
noremap <c-up> :m.-2<CR>
noremap <c-down> :m.+1<CR>
inoremap <c-CR> <Esc>
" c-CR maps to ^^ on mintty
inoremap <c-^> <Esc>

" some defaults that I like better
set laststatus=2
set incsearch
set smartcase
set number
set cursorline
set autoindent
set smartindent
set smarttab
set showcmd
set scrolloff=5
set nowrap
" set wildmenu  - might want to try this someday
" set wildignore+=*.class

" buffers and tabs
set hidden
noremap <M-Left> :bprev<CR>
noremap <M-Right> :bnext<CR>
" <m-left> & <m-right> for mintty
noremap [1;3D :bprev<CR>
noremap [1;3C :bnext<CR>
set switchbuf=usetab,newtab
nnoremap H :tabp<CR>
nnoremap L :tabn<CR>

" colors
if has("gui_running")
    colorscheme gruvbox
else
    colorscheme desert
endif

" turn on omni-complete
set omnifunc=syntaxcomplete#Complete
