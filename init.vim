"  __  __        __     _____ __  __ ____   ____
" |  \/  |_   _  \ \   / /_ _|  \/  |  _ \ / ___|
" | |\/| | | | |  \ \ / / | || |\/| | |_) | |
" | |  | | |_| |   \ V /  | || |  | |  _ <| |___
" |_|  |_|\__, |    \_/  |___|_|  |_|_| \_\\____|
"         |___/


" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ====================
" === Editor Setup ===
" ====================

" ===
" === System
" ===
"set clipboard=unnamed
let &t_ut=''
set autochdir


" ===
" === Editor behavior
" ===
set number
set relativenumber
set nocursorline
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=5
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set formatoptions-=tc
set splitright
set splitbelow
set mouse=a
set encoding=utf-8
set enc=utf8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set noshowmode
set showcmd
" set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu
exec "nohlsearch"
set ignorecase
set smartcase
set shortmess+=c
set inccommand=split


set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/nvim/tmp/undo,.
endif

" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" 复制到windows剪贴板 " How to "copy to clipboard" in vim of Bash on Windows? 
autocmd TextYankPost * if v:event.operator ==# 'y' | call system('/mnt/c/Windows/System32/clip.exe', @0) | endif

" Fcitx
let s:fcitx_cmd = executable("fcitx5-remote") ? "fcitx5-remote" : "fcitx-remote"

autocmd InsertLeave * let b:fcitx = system(s:fcitx_cmd) | call system(s:fcitx_cmd.' -c')

autocmd InsertEnter * if exists('b:fcitx') && b:fcitx == 2 | call system(s:fcitx_cmd.' -o') | endif

" ===
" === Terminal Behavior
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
"tnoremap <C-N> <C-\><C-N>:q<CR>

" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "
map ; :
map <C-;> <ESC>

" Save & quit
map Q :q<CR>
map S :w<CR>
noremap <LEADER>q <C-w>j:q<CR>

" Open the vimrc file anytime
map <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" Open Startify
map <LEADER>st :Startify<CR>


" 大写JKHL重复五次执行
noremap J 5j
noremap K 5k
noremap H 0
noremap L $
noremap <C-e> 5<C-e>
noremap <C-y> 5<C-y>

"在插入模式下移动光标 
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-o> <Delete>

"inoremap <C-j> <Esc>5<C-e>a
"inoremap <C-k> <Esc>5<C-y>a
" Copy to system clipboard
"vnoremap Y :w !xclip -i -sel c<CR>
nnoremap <LEADER>p "+p
nnoremap <LEADER>P "+P
vnoremap <LEADER>y "+y

" U to redo
nnoremap U <C-r>

" new line
nnoremap <LEADER>i i<CR><Esc>

" Joining lines
"noremap H J

" Indentation
nnoremap < <<
nnoremap > >>

" Search
map <LEADER><CR> :nohlsearch<CR>
"noremap . nzz
"noremap , Nzz

" Adjacent duplicate words
map <LEADER>dw /\(\<\w\+\>\)\_s*\1

" Folding
map <silent> <LEADER>o za


" ===
" === Cursor Movement
" Use <space> + new arrow keys for moving the cursor around windows
map <LEADER>w <C-w>w
map <LEADER>k <C-w>k
map <LEADER>j <C-w>j
map <LEADER>h <C-w>h
map <LEADER>l <C-w>l

" Disabling the default s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
map sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
map sj :set splitbelow<CR>:split<CR>
map sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
map sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap sch <C-w>t<C-w>K
" Place the two screens side by side
noremap scv <C-w>t<C-w>H

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H


" ===
" === Tab management
" ===
" Create a new tab with tu
map tu :tabe<CR>
" Move around tabs with tn and ti
map th :-tabnext<CR>
map tl :+tabnext<CR>
map td :tabclose<CR>
" Move the tabs with tmn and tmi
map tmh :-tabmove<CR>
map tml :+tabmove<CR>

" sudo vim
map <LEADER>sudo :w !sudo tee %


" ===
" === My Snippets
" ===
source ~/.config/nvim/snippits.vim


" ===
" === Other useful stuff
" ===

" Opening a terminal window
"map <LEADER>/ :set splitbelow<CR>:sp<CR>:term<CR>

" Press space twice to jump to the next '<++>' and edit it
map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4i

" Spelling Check with <space>sc
"map <LEADER>sc :set spell!<CR>
"noremap <C-s> ea<C-x>s
"inoremap <C-s> <Esc>ea<C-x>s
setlocal spell
set spelllang=nl,en_gb
inoremap <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u

" Press ` to change case (instead of ~)
"map ` ~

"imap <C-c> <Esc>zza
"nmap <C-c> zz

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

" Compile function
"map r :call CompileRunGcc()<CR>
"func! CompileRunGcc()
  "exec "w"
  "if &filetype == 'c'
    "exec "!g++ % -o %<"
    "exec "!time ./%<"
  "elseif &filetype == 'cpp'
    "exec "!g++ % -o %<"
    "exec "!time ./%<"
"elseif &filetype == 'java' 
    "exec "!javac %" 
    "exec "!java %<"
  "elseif &filetype == 'sh'
    ":!time bash %
  "elseif &filetype == 'python'
    "set splitright
    "":vsp
    "":vertical resize-10
    ":sp
    ":term python3 %
  "elseif &filetype == 'html'
    "exec "!chromium % &"
  "elseif &filetype == 'markdown'
    "exec "MarkdownPreview"
  "endif
"endfunc

" working on it...
map R :source $MYVIMRC<CR>
"map R :call CompileBuildrrr()<CR>
"func! CompileBuildrrr()
  "exec "w"
  "if &filetype == 'vim'
    "exec "source $MYVIMRC"
  "elseif &filetype == 'markdown'
    "exec "echo"
  "endif
"endfunc


" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.config/nvim/plugged')

" themes ============================================
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
"Plug 'bling/vim-bufferline'
"Plug 'liuchengxu/space-vim-theme'
Plug 'tomasr/molokai'
Plug 'dylanaraps/wal'

"Plug 'ajmwagar/vim-deus'

"set t_Co=256
"set termguicolors

"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"set background=dark    " Setting dark mode
""colorscheme deus
"let g:deus_termcolors=256

"Plug 'ojroques/vim-scrollstatus'

"let g:scrollstatus_size = 10
"let g:scrollstatus_symbol_track = ' '
"let g:scrollstatus_symbol_bar = '█'

" visual plugins ====================================

Plug 'itchyny/lightline.vim'

let g:lightline ={
    \ 'active': {
        \ 'right': [
            \['lineinfo'],
            \['percent'],
            \['scroll'],
            \['modified'],
            \ ['coc', 'fileformat', 'filetype']]
                \ },
    \ 'component_function':{
        \'scroll': 'ScrollStatus',
        \'coc': 'NearestMethodOrFunction',
        \ },
    \ }
let g:lightline.colorscheme = 'PaperColor'
set laststatus=2


" File navigation
"Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
"Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}

" Taglist ====================================

Plug 'liuchengxu/vista.vim'
noremap <LEADER>v :Vista!!<CR>
noremap <c-t> :silent! Vista finder coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()


" Error checking
"Plug 'w0rp/ale'

" Debug
"Plug 'puremourning/vimspector', { 'dir': '~/.config/nvim/plugged/vimspector/pack/*/opt/vimspector', 'do': ':VimspectorInstall vscode-cpptools debugpy'}

" support accelerating the moving speed
Plug 'rhysd/accelerated-jk'
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
let g:accelerated_jk_acceleration_table = [2, 4, 7, 15]

" Auto Complete
"Plug 'Valloric/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Undo Tree
Plug 'mbbill/undotree/'

" Internal terminal
Plug 'skywind3000/vim-terminal-help', { 'do': 'pip3 install neovim-remote' }  " requires 'pip3 install neovim-remote'


" Other visual enhancement
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'itchyny/vim-cursorword'
"Plug 'tmhedberg/SimpylFold'

" support indentLine
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'

" Git
"Plug 'rhysd/conflict-marker.vim'
"Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }

" HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json'
"Plug 'hail2u/vim-css3-syntax'
"Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
"Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"Plug 'pangloss/vim-javascript', { 'for' :['javascript', 'vim-plug'] }
"Plug 'mattn/emmet-vim'

" Python
Plug 'vim-scripts/indentpython.vim', { 'for' :['python', 'vim-plug'] }
"Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
"Plug 'plytophogy/vim-virtualenv', { 'for' :['python', 'vim-plug'] }

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'dkarter/bullets.vim', { 'for' :['markdown', 'vim-plug'] }

" For general writing
Plug 'reedes/vim-wordy'
Plug 'ron89/thesaurus_query.vim'

" Bookmarks
Plug 'kshenoy/vim-signature'

" vimtex
Plug 'lervag/vimtex'

" vim-snippets
Plug 'honza/vim-snippets'

" Other useful utilities
Plug 'tpope/vim-surround' " type ysiw' to wrap the word in Vis Mode with '' or type cs'` in Nor Mode to change 'word' to `word` or type ds' in Nor Mode to change 'word' to word.
Plug 'godlygeek/tabular' " type ;Tabularize /= to align the =
Plug 'gcmt/wildfire.vim' " in Visual mode, type i' to select all text in '', or type i) i] i} ip
Plug 'scrooloose/nerdcommenter' " in <space>cc to comment a line
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }
Plug 'tmhedberg/SimpylFold'
"Plug 'vim-scripts/restore_view.vim'
Plug 'AndrewRadev/switch.vim' " gs to switch
Plug 'ryanoasis/vim-devicons' " icons
Plug 'mg979/vim-visual-multi'
"Plug 'brglng/vim-im-select' " input method management

" support enchaned motion experience
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map <silent> r <Plug>(easymotion-overwin-f2)
" tpye r ande then type two characters to locate the place you want to go to.

"Plug 'luochen1990/rainbow'
"let g:rainbow_active = 1

" Dependencies
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'kana/vim-textobj-user'
"Plug 'roxma/nvim-yarp'

call plug#end()

" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
  let has_machine_specific_file = 0
  silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim


" ===
" === Dress up my vim
" ===
set termguicolors     " enable true colors support
color molokai
"colorscheme wal


"color deus
"let g:space_vim_transp_bg = 1
"set background=dark
"colorscheme space_vim_theme

" ===================== Start of Plugin Settings =====================

" ===
" === Airline
" ===
"let g:airline_theme='soda'
"let g:airline#extensions#coc#enabled = 0
"let g:airline#extensions#branch#enabled = 0
"let g:airline#extensions#tabline#enabled = 0
"let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"let g:airline_mode_map = {
      "\ '__' : '-',
      "\ 'n'  : 'Nor',
      "\ 'i'  : 'Ins',
      "\ 'R'  : 'Rpl',
      "\ 'c'  : 'Cmd',
      "\ 'v'  : 'Vis',
      "\ 'V'  : 'Vli',
      "\ '' : 'Vbl',
      "\ 's'  : 'S',
      "\ 'S'  : 'S',
      "\ '' : 'S',
      "\ }


" ===
" === NERDTree
" ===
"map tt :NERDTreeToggle<CR>
"let NERDTreeMapOpenExpl = ""
"let NERDTreeMapUpdir = "H"
"let NERDTreeMapUpdirKeepOpen = "h"
"let NERDTreeMapOpenSplit = ""
"let NERDTreeMapOpenVSplit = "<leader><CR>"
"let NERDTreeMapActivateNode = "i"
"let NERDTreeMapOpenInTab = "o"
"let NERDTreeMapOpenInTabSilent = "O"
"let NERDTreeMapPreview = ""
"let NERDTreeMapCloseDir = ""
"let NERDTreeMapChangeRoot = "l"
"let NERDTreeMapMenu = ","
"let NERDTreeMapToggleHidden = "zh"


" ==
" == NERDTree-git
" ==
"let g:NERDTreeIndicatorMapCustom = {
    "\ "Modified"  : "✹",
    "\ "Staged"    : "✚",
    "\ "Untracked" : "✭",
    "\ "Renamed"   : "➜",
    "\ "Unmerged"  : "═",
    "\ "Deleted"   : "✖",
    "\ "Dirty"     : "✗",
    "\ "Clean"     : "✔︎",
    "\ "Unknown"   : "?"
    "\ }


" ===
" === coc.nvim
" ===

"let g:coc_node_path = '/usr/bin/node'
silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-json', 'coc-yank', 'coc-lists', 'coc-gitignore', 'coc-clangd', 'coc-ccls', 'coc-pairs', 'coc-snippets', 'coc-translator', 'coc-actions',  'coc-explorer', 'coc-vimtex', 'coc-lua']
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" use <tab> for trigger completion and navigate to the next complete item
set updatetime=100
set shortmess+=c

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]	=~ '\s'
endfunction

hi CocMenuSel ctermbg=237 guibg=#13354A  " highlight color of the selected term of the coc completion menu
set pumblend=15  " make the coc completion menu semi-transparent
"inoremap <silent><expr> <Tab>
            "\ pumvisible() ? "\<C-n>" :
            "\ <SID>check_back_space() ? "\<Tab>" :
            "\ coc#refresh()
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"inoremap <silent><expr> <CR> pumvisible() ? "\<C-y><CR>" : "\<CR>"


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd CursorHold * silent! call CocActionAsync('highlight')

function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
" Use <leader><F1> to show documentation in preview window.
nnoremap <silent> <leader><F1> :call <SID>show_documentation()<CR>
nmap tt :CocCommand explorer<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)

" ===
" === some error checking
" ===
"let g:ale_virtualtext_cursor = 1
"let g:ale_linters = {
			"\ 'cs': ['OmniSharp'],
			"\ 'go': ['vim-go'],
			"\ 'c' : ['ccls']
			"\}
"let g:ale_cpp_ccls_init_options = {
			"\   'cache': {
			"\       'directory': '/tmp/ccls/cache'
			"\   }
			"\ }
"let g:ale_c_gcc_executable = '/usr/bin/gcc'
"let g:ale_c_gcc_options="-Wall -O2"
"

" ===
" === indentLine
" ===
let g:indentLine_char = '│'
let g:indentLine_color_term = 238
let g:indentLine_color_gui = '#333333'
silent! unmap <LEADER>ig
autocmd WinEnter * silent! unmap <LEADER>ig


" ===
" === Vimspector
" ===
"let g:vimspector_enable_mappings = 'HUMAN'
"let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools' ]
"set packpath=~/.config/nvim/plugged/vimspector
"packadd! vimspector

" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'


" ===
" === Python-syntax
" ===
let g:python_highlight_all = 1
" let g:python_slow_sync = 0




" ===
" === vim-table-mode
" ===
map <LEADER>tm :TableModeToggle<CR>


" ===
" === FZF
" ===
map <C-p> :FZF<CR>

" ===
" === vim-virtual-multi
" ===
let g:VM_maps = {}

let g:VM_maps['Add Cursor Down'] = '<C-j>'
let g:VM_maps['Add Cursor Up']   = '<C-k>'


" ===
" === vim-signature
" ===
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "dm-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "dm/",
        \ 'PurgeMarkers'       :  "dm?",
        \ 'GotoNextLineAlpha'  :  "m<LEADER>",
        \ 'GotoPrevLineAlpha'  :  "",
        \ 'GotoNextSpotAlpha'  :  "m<LEADER>",
        \ 'GotoPrevSpotAlpha'  :  "",
        \ 'GotoNextLineByPos'  :  "",
        \ 'GotoPrevLineByPos'  :  "",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "",
        \ 'GotoPrevMarker'     :  "",
        \ 'GotoNextMarkerAny'  :  "",
        \ 'GotoPrevMarkerAny'  :  "",
        \ 'ListLocalMarks'     :  "m/",
        \ 'ListLocalMarkers'   :  "m?"
        \ }


" ===
" === Undotree
" ===
map <LEADER>ut :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1


" ===
" === vimtex
" ===
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode = 0
"使vimtex默认xelatex为编译器
let g:vimtex_compiler_latexmk_engines = {'_':'-xelatex'}
let g:vimtex_compiler_latexrun_engines ={'_':'xelatex'}

let g:vimtex_compiler_progname = 'nvr' " pip3 install neovim-remote
"let g:vimtex_view_general_viewer = 'zathura'
"let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_viewer = '/mnt/f/SumatraPDF/SumatraPDF.exe' "这里放置你的sumatrapdf 安装路径
"let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_view_general_options
     \ = ' -reuse-instance -forward-search @tex @line @pdf'
     \ . ' -inverse-search "' . 'cmd /c start /min \"\" '  . exepath(v:progpath)
     \ . ' -v --not-a-term -T dumb -c  \"VimtexInverseSearch %l ''%f''\""' "for vim/gvim
" add following content into ~/.config/.zathrarc
"# ~/.config/zathura/zathurarc
"set synctex true
"set synctex-editor-command "nvr --remote-silent %f -c %l"
let g:vimtex_toc_config = {
            \ 'name' : 'TOC',
            \ 'layers' : ['content', 'todo', 'include'],
            \ 'split_width' : 25,
            \ 'todo_sorted' : 0,
            \ 'show_help' : 1,
            \ 'show_numbers' : 1,
            \}

" :h conceallevel
set conceallevel=0
set concealcursor=nc
" let the conceal part not so dim
autocmd BufEnter *.* hi Conceal ctermbg=none ctermfg=lightgrey guibg=none guifg=lightgrey
let g:tex_conceal='abdmg'



" ==
" == thesaurus_query
" ==
map <LEADER>th :ThesaurusQueryLookupCurrentWord<CR>


" Startify
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]


" ===
" === Far.vim
" ===
nnoremap <silent> <LEADER>f :F  %<left><left>



" ===
" === emmet
" ===
let g:user_emmet_leader_key='<C-f>'


" ===
" === Bullets.vim
" ===
let g:bullets_set_mappings = 0


" ===================== End of Plugin Settings =====================

" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
  exec "e ~/.config/nvim/_machine_specific.vim"
endif
