" plugin.vim
" Configuration for (Neo)Vim plugins.
" Usage: Source this file.  source base.vim in ~/.vimrc
" Dependencies:
" - (Neo)Vim Plugins (already checked into this repo)


" Pathogen Plugin Manger
" ======================

call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on


" Color Schemes
" =============

" Zenburn: Good but dark
" colorscheme zenburn

" GruvBox: Provides decent light mode
let g:gruvbox_bold='1'
let g:gruvbox_underline='1'
let g:gruvbox_undercurl='1'
let g:gruvbox_italic='1'
" let g:gruvbox_hls_cursor='red'  " Not getting reflected?
" let g:gruvbox_contrast_light='hard'
colorscheme gruvbox
" Set Background
" Following system command returns without error only if the current mode is
" Dark mode.  This detect Light/Dark mode in Auto mode as well.
let s:sys = system("if [[ $(uname) == 'Darwin' ]]; then defaults read -g AppleInterfaceStyle 2&>/dev/null; else exit 1; fi")
if v:shell_error
	set background=light
else
	set background=dark
endif
nnoremap <C-L> :call gruvbox#hls_toggle()<CR><C-L>

" Update highlighting for matched parenthesis to make it easier to see
hi MatchParen cterm=bold ctermbg=none ctermfg=124 gui=bold guibg=#bdae93


" Ultisnips Snippet Engine
" ========================

" Set the trigger key (g:UltiSnipsExpandTrigger)
" Options: <nop>, <c-space>, ...
" let g:UltiSnipsExpandTrigger = "<c-space>"
let g:UltiSnipsListSnippets="<S-tab>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetsDir="~/.vim/custom-snippets"
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'custom-snippets']
" let g:UltiSnipsEnableSnipMate=0  A lot of snippets are defined here


" LeaderF Fuzzy Searching
" =======================

" Disable all previews; <C-p> to preview manually
let g:Lf_PreviewResult = { 'BufTag': 0, 'Function': 0 }

" Use Popup window
" let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1

" Disable use of version control to create file index
" (By default LeaderF uses `git ls-tree` to create file index.  This won't work
" if we are in a folder that is .gitignored.)
let g:Lf_UseVersionControlTool = 0

" nmap <Leader>jf  :LeaderfFile<CR>
" nmap <Leader>jb  :LeaderfBufferAll<CR>
nmap <Leader>jt  :LeaderfTag<CR>
nmap <Leader>jl  :LeaderfLine<CR>
nmap <Leader>jrg <Plug>LeaderfRgCwordLiteralBoundary
nmap <Leader>hl  :LeaderfSelf<CR>


" PowerLine Status Line
" =====================

set noshowmode				" Vim doesn't need to show status line

let g:lightline = { 
			\ 'colorscheme': 'gruvbox',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'readonly', 'filename', 'gitbranch', 'cocstatus' ] ],
			\   'right': [ [ 'lineinfo' ],
			\              [ 'percent' ] ]
			\ },
			\ 'inactive': {
			\   'left': [ [ 'filename' ] ]
			\ },
			\ 'component_function': {
			\   'filename': 'LightlineFilename',
			\   'gitbranch': 'fugitive#head',
			\   'cocstatus': 'coc#status'
			\ },
			\ }

function! LightlineFilename()
	let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
	let modified = &modified ? ' +' : ''
	return filename . modified
endfunction

" autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()


" coc.vim
" =======
source ~/.dotfiles/vim/coc.vim


" Fugitive Git Integration
" ========================

" Shortcuts-
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>go :Git ok<CR>

" Delete buffers created by Fugitive
autocmd BufReadPost fugitive://* set bufhidden=delete


" vim-slime Sending commands
" ==========================

" Disable Slime's default key mapping
let g:slime_no_mappings = 1
" Slime Send (normal)
nmap <leader>ss <Plug>SlimeLineSend
" Slime Send (visual-selected text)
xmap <leader>ss <Plug>SlimeRegionSend
" change Slime Config
nmap <leader>sc <Plug>SlimeConfig

" tmux
" ----
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
" ":"       means current window, current pane (a reasonable default)
" ":i"      means the ith window, current pane
" ":i.j"    means the ith window, jth pane
" "h:i.j"   means the tmux session where h is the session identifier
"           (either session name or number), the ith window and the jth pane
" "%i"      means i refers the pane's unique id
" "{token}" one of tmux's supported special tokens, like "{last}"

" NeoVim
" ------
" let g:slime_target = "neovim"
" nmap <leader>si :echo b:terminal_job_id<CR>
nmap <leader>si :echo &channel<CR>


" Syntastic
" =========
" Deprecated: Issues in getting it to work???
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" 
" " let g:syntastic_mode_map = {"mode": "active"}
" let g:syntastic_mode_map = {"mode": "passive"}


" netrw
" -----

let g:netrw_liststyle=3
" let g:netrw_browse_split=4
" let g:netrw_preview=1
" let g:netrw_winsize=20


" vim-go
" ======

let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
" let g:go_highlight_structs = 1
" let g:go_highlight_fields = 1    " struct fields
let g:go_highlight_interfaces = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
let g:go_highlight_build_constraints = 1  " '// +build linux'

" Auto :GoSameIds (and :GoSameIdsClear)
" let g:go_auto_sameids = 1  " Cause garbling of display

" let g:go_term_mode = "split"
let g:go_fmt_command = "goimports"

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction


" Nvim-R
" ======
let r_indent_align_args = 0


" Gundo.vim
" =========
" Whether to place the preview window at the bottom of file.
" let g:gundo_preview_bottom = 1
let g:gundo_width = 60            " Set width of window used by Gundo.vim

" Open :Gundo windows
nnoremap <leader>u :GundoToggle<CR>


" ==== OBSOLETED ====

" ctrlp.vim
" =========
" Obsoleted: Use LeaderF instead.
" " let g:ctrlp_working_path_mode = 'ra'  (default setting)
" let g:ctrlp_working_path_mode = 'a'
" " Reuse cache accross sessions
" let g:ctrlp_clear_cache_on_exit = 0

