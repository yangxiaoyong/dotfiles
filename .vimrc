set runtimepath=~/.vim,$VIMRUNTIME,~/.vim/after
" enable clipboard and other Win32 features
" source $VIMRUNTIME/mswin.vim

"
" appearance options
"
set bg=dark
let g:zenburn_high_Contrast = 1
let g:liquidcarbon_high_contrast = 1
let g:molokai_original = 0
set t_Co=256
colorscheme molokai

if has("gui_running")
   " set default size: 90x35
   set columns=90
   set lines=35
   " No menus and no toolbar
   set guioptions-=m
   set guioptions-=T
   let g:obviousModeInsertHi = "guibg=Black guifg=White"
else
   let g:obviousModeInsertHi = "ctermfg=253 ctermbg=16"
endif

set modeline
set tabstop=4 " tab size = 2
set shiftwidth=4 " soft space = 2
set smarttab
set expandtab " expand tabs
set wildchar=9 " tab as completion character

set virtualedit=block
set clipboard+=unnamed  " Yanks go on clipboard instead.
set showmatch " Show matching braces.

" Line wrapping on by default
set wrap
set linebreak

if has("win32") || has("win64")
   set guifont=Envy\ Code\ R:h12.5
   let Tlist_Ctags_Cmd = 'e:\Tools\ctags.exe'
   set directory=$TMP
   if !has("gui_running")
      colorscheme slate
   end
elseif has("mac")
   set directory=/tmp
   set guifont=Envy\ Code\ R:h14
else
   set directory=/tmp
   set guifont=Envy\ Code\ R\ 14
endif

set history=50 " keep track of last commands
set number ruler " show line numbers
set incsearch " incremental searching on
set hlsearch " highlight all matches
set smartcase
set cursorline
set selectmode=key
set showtabline=2 " show always for console version
set tabline=%!MyTabLine()
set wildmenu " menu on statusbar for command autocomplete
" default to UTF-8 encoding
set encoding=utf8
set fileencoding=utf8
" enable visible whitespace
set listchars=tab:»·,trail:·,precedes:<,extends:>
set list

" no beep
autocmd VimEnter * set vb t_vb=

" tab navigation like firefox
nmap <C-S-tab> :tabprevious<cr>
nmap <C-tab> :tabnext<cr>
map <C-S-tab> :tabprevious<cr>
map <C-tab> :tabnext<cr>
imap <C-S-tab> <ESC>:tabprevious<cr>i
imap <C-tab> <ESC>:tabnext<cr>i
nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr>
" map \tx for the console version as well
if !has("gui_running")
   nmap <Leader>tn :tabnext<cr>
   nmap <Leader>tp :tabprevious<cr>
   nmap <Leader><F4> :tabclose<cr>
end

" Map Ctrl-E Ctrl-W to toggle linewrap option like in VS
noremap <C-E><C-W> :set wrap!<CR>
" Map Ctrl-M Ctrl-L to expand all folds like in VS
noremap <C-M><C-L> :%foldopen!<CR>
" Remap omni-complete to avoid having to type so fast
inoremap <C-Space> <C-X><C-O>

" Windows like movements for long lines with wrap enabled:
noremap j gj
noremap k gk

" Use pathogen.vim to manage and load plugins
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" disable warnings from NERDCommenter:
let g:NERDShutUp = 1

" Make sure taglist doesn't change the window size
let g:Tlist_Inc_Winwidth = 0
nnoremap <silent> <F8> :TlistToggle<CR>

" language specific customizations:
let g:python_highlight_numbers = 1

" set custom file types I've configured
au BufNewFile,BufRead *.ps1  setf ps1
au BufNewFile,BufRead *.boo  setf boo
au BufNewFile,BufRead *.config  setf xml
au BufNewFile,BufRead *.xaml  setf xml
au BufNewFile,BufRead *.xoml  setf xml
au BufNewFile,BufRead *.blogTemplate  setf xhtml
au BufNewFile,BufRead *.brail  setf xhtml
au BufNewFile,BufRead *.rst  setf xml
au BufNewFile,BufRead *.rsb  setf xml
au BufNewFile,BufRead *.io  setf io
au BufNewFile,BufRead *.notes setf notes
au BufNewFile,BufRead *.mg setf mg

syntax on " syntax hilight on
syntax sync fromstart
filetype plugin indent on

runtime xmlpretty.vim
command! -range=% Xmlpretty :call XmlPretty(<line1>, <line2>)
map <C-K><C-F> :Xmlpretty<CR>

"
" Bind NERD_Tree plugin to a <Ctrl+E,Ctrl+E>
"
noremap <C-E><C-E> :NERDTree<CR>
noremap <C-E><C-C> :NERDTreeClose<CR>

"
" Configure TOhtml command
"
let html_number_lines = 0
let html_ignore_folding = 1
let html_use_css = 1
"let html_no_pre = 0
let use_xhtml = 1

"
" Configure Ku
"
call ku#custom_prefix('common', '~', $HOME)
call ku#custom_prefix('common', '.vim', $HOME.'/.vim')
let g:ku_component_separators='/\\'
"
" Configure syntax specific options
"
let python_highlight_all = 1

"
" Enable spellchecking conditionally
"
map <Leader>se :setlocal spell spelllang=en_us<CR>
map <Leader>ss :setlocal spell spelllang=es_es<CR>
map <Leader>sn :setlocal nospell<CR>

"
" Other stuff
"
runtime 'macros/matchit.vim'
nmap <leader>R :RainbowParenthesesToggle<CR>
" these are supposed to be done on syntax files, but
" they fit pretty much everything I work on.
au BufNewFile,BufRead *.* call rainbow_parentheses#LoadRound()
au BufNewFile,BufRead *.* call rainbow_parentheses#LoadSquare()
au BufNewFile,BufRead *.* call rainbow_parentheses#LoadBraces()

"
" Configure tabs for the console version
"
function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction

"
" Status line configuration gotten from: http://rgarciasuarez.free.fr/dotfiles/vimrc
"
set ls=2 " Always show status line
if has('statusline')
   " Status line detail:
   " %f		file path
   " %y		file type between braces (if defined)
   " %([%R%M]%)	read-only, modified and modifiable flags between braces
   " %{'!'[&ff=='default_file_format']}
   "			shows a '!' if the file format is not the platform
   "			default
   " %{'$'[!&list]}	shows a '*' if in list mode
   " %{'~'[&pm=='']}	shows a '~' if in patchmode
   " (%{synIDattr(synID(line('.'),col('.'),0),'name')})
   "			only for debug : display the current syntax item name
   " %=		right-align following items
   " #%n		buffer number
   " %l/%L,%c%V	line number, total number of lines, and column number
   function! SetStatusLineStyle()
      if &stl == '' || &stl =~ 'synID'
         let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}%{'~'[&pm=='']}%=#%n %l/%L,%c%V "
      else
         let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=#%n %l/%L,%c%V "
      endif
   endfunc
   " Switch between the normal and vim-debug modes in the status line
   nmap _ds :call SetStatusLineStyle()<CR>
   call SetStatusLineStyle()
   " Window title
   if has('title')
    set titlestring=%t%(\ [%R%M]%)
   endif
endif

" 去掉每行尾的空白
" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()


" === NERDTree ===
map <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore=[]
let NERDTreeShowHidden=1
" === END ===


" === PHP ===

autocmd FileType php noremap <C-M> :w!<CR>:!/apps/lib/php5/bin/php %<CR>
autocmd FileType php noremap <C-L> :!/apps/lib/php5/bin/php -l %<CR>

" autocmd FileType php source ~/.vim/plugin/php-doc.vim
" autocmd FileType php noremap <C-P> :call PhpDocSingle()<CR>
"autocmd FileType php vnoremap <C-P> :call PhpDocRange()<CR>
"autocmd FileType php inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
autocmd FileType php noremap <F8> oif<SPACE>() {<ESC>o}<ESC>kf(a
autocmd FileType php inoremap function function() {}<ESC>F{a<CR><ESC>k^f(i
autocmd FileType php inoremap ?php <?php<CR>?><ESC>O
" nnoremap <C-P> :call PhpDocSingle()<CR>

" === END ===

" C的缩进使用tab制表符
autocmd FileType c,cpp set noexpandtab
" HTML的缩紧使用2个空格
autocmd FileType html set shiftwidth=2 tabstop=2

" === 键盘映射 ==
nnoremap <silent> <F2> :set paste<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
nnoremap <silent> <F4> :TlistToggle<CR>
nnoremap <silent> <F5> :Vimwiki2HTML<cr>

nnoremap <leader><Space> <Plug>VimwikiToggleListItem

" 映射一个W的命令，强制保存当前的内容
command W w !sudo tee % > /dev/null

" for python
autocmd FileType python inoremap pdb import ipdb;ipdb.set_trace()
autocmd FileType python inoremap #p # -*- encoding:utf-8 -*-
autocmd FileType python inoremap #_ #!/usr/bin/env python<ESC>o# -*- encoding:utf-8 -*-
autocmd FileType python inoremap xdate <c-r>=strftime("20%y-%m-%d")<cr>
" autocmd FileType python inoremap __ if __name__ == "__main__":
" === END ===
"
" === VIM_WIKI ===
let g:vimwiki_menu = ''
let g:vimwiki_CJK_length = 1
let g:vimwiki_use_mouse = 1
let g:vimwiki_list = [{'path': '~/vimwiki/KMS', 'diary_link_fmt': '%Y-%m-%d',
                       \ 'template_ext': '.html', 'diary_link_count': 4,
                       \ 'syntax': 'default', 'index': 'index', 'diary_header': 'Diary',
                       \ 'ext': '.wiki', 'diary_rel_path': 'diary/',
                       \ 'path_html' : '~/vimwiki/html', 'temp': 0,
                       \ 'template_path': '~/vimwiki/templates/',
                       \ 'html_header': '~/vimwiki/templates/header.tpl'},
                       \ {'path': '~/vimwiki/Life', 'path_html': '~/vimwiki/html',
                       \  'html_header': '~/vimwiki/templates/header.tpl'}]

"
" === END ===

" === LUA ===
" 增加lua的自动补全
let g:lua_complete_omni=1
let g:lua_compiler_name = '/usr/bin/luac'
" === END ===
