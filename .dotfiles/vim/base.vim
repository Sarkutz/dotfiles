" base.vim
" Basic (Neo)Vim configuration suitable for all Vim installations.
" Usage: Source this file.  source base.vim in ~/.vimrc
" Dependencies: None


" View
" ====

set mouse=						" disable mouse
set number relativenumber       " line numbers
set showcmd						" showcmd on bottom line
set scrolloff=2					" context lines above and below, always
set ruler                       " show position in file on bottom right
set laststatus=2				" Always show status line

" Text wrapping and highlighting lines that overflow
set textwidth=0
highlight ColorColumn ctermbg=red ctermfg=blue
call matchadd('ColorColumn', '\%81v', 100)


" Editing
" =======

set autoindent					" copy indent from previous line
set smartindent					" consider program blocks and comments
set pastetoggle=<F9>			" toggle paste mode


" Behaviour
" =========

set nocompatible				" make non-compatible with Vi
set tags=./tags;				" search current file's directory and upward
set splitright					" for vertical split, open window to right
set backspace=indent,eol,start  " let backspace delete these characters
set directory=.,~/tmp,/var/tmp,/tmp  " Swap file directories
set path+=**

" Put stty -ixon -ixoff in bashrc
map <C-S> :w<CR>

" Spell Check
" -----------
"  spellfile=~/.vim/spell/...
set spell spelllang=en_gb
set nospell

" Searching
" ---------
set ignorecase
set smartcase
set incsearch
set hlsearch

" Shell
" -----
" -i: set interactive shell so we use aliases
" (-c is present by default)
" Unfortunatly, this causes :Gdiff (vim-fugitive) to open a three-way diff!
" :Gdiff just does: git ls-files --unmerged -- <filename>
" set shellcmdflag=-ic


" Shortcuts
" =========

let mapleader = " "				" use <space> over \ as leader

" Close window
nnoremap <C-Q> :q<CR>
" Open new tab
nnoremap <leader>tn :tabnew<CR>
" Close location list
noremap <Leader>cq :ccl <bar> lcl<CR>
" Copy visually selected text to clipboard selection using <C-c>
map <C-c> "+y<CR>
" Get :pwd
nmap <leader>d :pwd<CR>


" Handling swap files???
function! Recover()
	write %.rec
	:edit!
	diffsplit %.rec
endfunction

" Pretty print visually selected JSON
vmap <leader>djpp :!jq '.'<CR>  


" NeoVim
" ======
" set nocscopeverbose				" NeoVim waits for user input (before loading)
								" after reading a cscope database


" Useful Commands
" ===============

"" Show invisible chars
" enable lists:
" set list
" ctrl+v u25b8 = ▸; 00ac=¬
" set listchars=eol:¬,tab:▸-

"" Auto-complete: Set include path for NS-3.
" set path+=${HOME}/ns/ns-3-allinone/ns-3-dev/src/**


" Testing
" =======

