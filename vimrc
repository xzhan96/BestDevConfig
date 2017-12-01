set nocompatible

"set term=screen-256color
set background=dark
set t_Co=256

set backspace=indent,eol,start

set nobk
set tags=tags;

set history=100		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ic

syntax on 
if &t_Co > 2 || has("gui_running")
 "colorscheme office-dark
 "colorscheme vrunchbang-light
 "colorscheme solarized
 "colorscheme freya
 colorscheme colorsbox-material
  set hlsearch
else
  colorscheme colorsbox-material
endif

if has("autocmd")

  filetype plugin indent on

  augroup vimrcEx
  au!

  autocmd FileType text setlocal textwidth=78

  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

set autoindent		" always set autoindenting on

endif " has("autocmd")

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"colorscheme lanzarotta
"colorscheme desertEx
"colorscheme molokai

"syntax enable
"if has('gui_running')
"	set background=light
"else
"	set background=dark
"endif

"colorscheme solarized

set nu

"let g:NERDTree_title='NERD Tree'
"function! NERDTree_Start()
"        exec 'NERDTree'
"endfunction
"
"function! NERDTree_IsValid()
"        return 1
"endfunction

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
"let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWindowLayout = 'BufExplorer|FileExplorer, TagsExplorer'
"let g:winManagerWindowLayout = 'BufExplorer'

" 显示/隐藏 MiniBufExplorer 窗口
map <Leader>b :TMiniBufExplorer<cr>
let g:winManagerWidth=35
let g:bufExplorerMaxHeight=50
"let g:miniBufExplorerMoreThanOne=0
"let g:miniBufExplMapWindowNavVim = 1 
"let g:miniBufExplMapWindowNavArrows = 1 
"let g:miniBufExplMapCTabSwitchBufs = 1 
"let g:miniBufExplModSelTarget = 1 


nmap wm :WMToggle<cr>
map <c-w><c-f> :FirstExplorerWindow<cr> 
map <c-w><c-b> :BottomExplorerWindow<cr>

"let g:miniBufExplMapWindowNavArrows = 1

":set cscopeprg=gtags-cscope
":cs add GTAGS

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
     cs add cscope.out
  endif
 set csverb
endif
"在插入模式下移动光标
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" This is for new-omni-completion
filetype plugin indent on
set completeopt=longest,menu

""""""""""""""""""""""""""""""
" lookupfile setting
" """"""""""""""""""""""""""""""
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
if filereadable("./filenametags")                "设置tag文件的名字
let g:LookupFile_TagExpr ='"./filenametags"'
endif
nmap <silent> <F6> :LUBufs<CR>

"映射LookupFile为,lk
"nmap <silent> <leader>lk :LUTags<cr>
""映射LUBufs为,ll
"nmap <silent> <leader>ll :LUBufs<cr>
""映射LUWalk为,lw
"nmap <silent> <leader>lw :LUWalk<cr>

" vim insert mode Auto-completion
set wildmenu   "显示补全列表
set wildmode=longest:full   "补全行为设置

"
" guicolorscheme plugin setup 
" 
" if (&t_Co == 256 || &t_Co == 88) && !has('gui_running') && filereadable(expand("$HOME/.vim/plugin/guicolorscheme.vim"))
"	runtime! plugin/guicolorscheme.vim
"	"GuiColorScheme desertEx
"	GuiColorScheme freya
"else
"	"colorscheme desertEx
"	 colorscheme freya
"endif
"
"

autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
"""定义函数SetTitle，自动插入文件头
func SetTitle()
	"如果文件类型为.sh文件
	if &filetype == 'sh'
	call setline(1,"\#########################################################################")
	call append(line("."), "# File Name: ".expand("%"))
	call append(line(".")+1, "# Author: xiaofeng zhang")
	call append(line(".")+2, "# mail: xiaofeng.zhang@intel.com")
	call append(line(".")+3, "# Created Time:".strftime("%c"))
	call append(line(".")+4, "# #########################################################################")
	call append(line(".")+5,"#!/bin/bash")
	call append(line(".")+6,"")
else
	call setline(1, "/*************************************************************************")
	call append(line("."), " * File Name: ".expand("%"))
	call append(line(".")+1, " * Author: xiaofeng zhang")
	call append(line(".")+2, " * Mail: xiaofeng.zhang@intel.com ")
	call append(line(".")+3, " * Created Time: ".strftime("%c"))
	call append(line(".")+4, " ************************************************************************/")
	call append(line(".")+5, "")
endif
if &filetype == 'cpp'
	call append(line(".")+6, "#include<iostream>")
	call append(line(".")+7, "using namespace std;")
	call append(line(".")+8, "")
endif
if &filetype == 'c'
	call append(line(".")+6, "#include<stdio.h>")
	call append(line(".")+7, "")
endif
"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G
endfunc

"CtrlP plugin
"It's totally useless and waste my time to use it
"..... -- by xiaofeng, 2016.7. 25
"------------------------
"set runtimepath^=~/.vim/bundle/ctrlp.vim
"
"let g:ctrlp_map = '<leader>p'
"let g:ctrlp_cmd = 'CtrlP'
"map <leader>f :CtrlPMRU<CR>
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/]\.(git|out|svn)$',
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }
"let g:ctrlp_working_path_mode='raw'
"let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:1000,results:1000'
"let g:ctrlp_match_window_reversed=0
"let g:ctrlp_mruf_max=500
"let g:ctrlp_follow_symlinks=1
"let g:ctrlp_max_files=0 
"let g:ctrlp_max_depth = 40


"rainbow_parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

nnoremap <F10> :RainbowParenthesesToggle<CR>
execute pathogen#infect()
call pathogen#helptags()

