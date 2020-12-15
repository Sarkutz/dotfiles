" ft.vim
" Configurations that are File Type specific.
" Usage: Source this file.  source base.vim in ~/.vimrc
" Dependencies:
" - vim-go Plugin (already checked into this repo)


augroup Vimrc
autocmd!


" File type: text
" ===============

function! ConfigText()
	setlocal textwidth=78
	setlocal nosmartindent
endfunction
autocmd Filetype text call ConfigText()


" File type: rst
" ==============

function! ConfigRst()
	setlocal textwidth=78
	setlocal tabstop=3 softtabstop=3 shiftwidth=3 expandtab
	
	" Double Title: `` :Dtitle [=-] ``
	" command! -nargs=1 Dtitle normal! yyPpI <ESC>k:s/./<args>/g<CR>A<args><args><ESC>jj:s/./<args>/g<CR>A<args><args><ESC>:nohlsearch<CR>
	" Single Title: `` :Stitle [=-~] ``
	" command! -nargs=1 Stitle normal yyp:s/./<args>/g<CR>:nohlsearch<CR>

endfunction
autocmd Filetype rst call ConfigRst()


" File type: C/C++
" ================

function! ConfigC()
	setlocal textwidth=78
	setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab

	" Folding
	" ???
	syn sync fromstart
	setlocal foldmethod=syntax
	" foldnestmax: max. levels to fold
	setlocal foldnestmax=1
endfunction
autocmd Filetype c call ConfigC()
autocmd Filetype cpp call ConfigC()


" File type: make
" ===============

function! ConfigMake()
	setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
	setlocal list
	setlocal listchars=eol:¬,tab:▸-
endfunction
autocmd Filetype make call ConfigMake()


" File type: python
" =================

function! ConfigPython()
	setlocal textwidth=79
	setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
	set fileformat=unix
	set encoding=utf-8

	" Python with virtualenv support
	" 	py3<<EOF
	" import os
	" import sys
	" if 'VIRTUAL_ENV' in os.environ:
	" 	project_base_dir = os.environ['VIRTUAL_ENV']
	" 	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	" 	with open(activate_this) as f:
	" 		exec(f.read(), dict(__file__=activate_this))
	" EOF
	" execfile(activate_this, dict(__file__=activate_this)) won't work

	" Test this out
	" let python_highlight_all=1
endfunction
autocmd Filetype python call ConfigPython()

function! BufWritePrePython()
" execute ':!black --fast %'
endfunction
autocmd BufWritePost *.py call BufWritePrePython()


" File type: sh
" =============

function! ConfigSh()
	setlocal textwidth=0
	setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
endfunction
autocmd Filetype sh call ConfigSh()


" File type: r
" ============

let R_assign = 0
function! ConfigR()
	setlocal textwidth=0
	setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab

endfunction
autocmd Filetype r call ConfigR()


" File type: MATLAB/Octave
" ========================

function! ConfigMatlab()
	setlocal textwidth=0
	setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
endfunction
autocmd Filetype matlab call ConfigMatlab()


" File type: tex
" ==============

function! ConfigTeX()
	setlocal textwidth=78
	setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
endfunction
autocmd Filetype tex call ConfigTeX()


" File type: html/xml
" ===================
function! ConfigHtml()
	setlocal textwidth=78
	setlocal tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
endfunction
autocmd Filetype html call ConfigHtml()
autocmd Filetype xml call ConfigHtml()


" File type: yaml
" ===============
function! ConfigYaml()
	setlocal textwidth=78
	setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
endfunction
autocmd Filetype yaml call ConfigYaml()


" File type: vim
" ==============

function! ConfigVim()
	setlocal textwidth=0
	setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
endfunction
autocmd Filetype vim call ConfigVim()


" File type: golang
" =================

function! ConfigGo()
	setlocal textwidth=78
	setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab

	" Requires vim-go plugin
	nmap <leader>gr <Plug>(go-run)
	nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
	nmap <leader>gt <Plug>(go-test)
	nmap <leader>gct <Plug>(go-coverage-toggle)
	nmap <leader>gl :GoMetaLinter<CR>
endfunction
autocmd Filetype go call ConfigGo()


" File type: crontab
" ==================

function! ConfigCrontab()
	" Fix error 'crontab: temp file must be edited in place'
	setlocal nobackup nowritebackup
endfunction
autocmd Filetype crontab call ConfigCrontab()


augroup end

