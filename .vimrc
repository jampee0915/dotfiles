let mapleader = "\<space>"

" leader+wでファイル保存
noremap <leader>w :w<cr>

" windowを分割する
nmap ss :split<cr><C-w>w
nmap sv :vsplit<cr><C-w>w

"-----------------------------------------------------------------
" encoding
"-----------------------------------------------------------------
" ファイル読み込み時の文字コード設定
set encoding=utf-8

" マルチバイト文字を使う場合の設定
scriptencoding utf-8

" 保存時の文字コード
set fileencoding=utf-8

" 読み込み時の文字コードの自動判別
set fileencodings=ucs-boms,utf-8,euc-jp,cp932

"-----------------------------------------------------------------
" tab/indent
"-----------------------------------------------------------------
" タブ入力を複数の空白入力に置き換える
set expandtab

" 画面上でタブ文字が占める幅
set tabstop=4

" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4

" 改行時に前の行のインデントを継続する
set autoindent

" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent

" smartindentで増減する幅
set shiftwidth=4

"-----------------------------------------------------------------
" cursor
"-----------------------------------------------------------------
" カーソルラインをハイライト
set cursorline

" カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set whichwrap=b,s,h,l,<,>,[,],~

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

"-----------------------------------------------------------------
" search
"-----------------------------------------------------------------
" インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch

" 検索パターンに大文字小文字を区別しない
set ignorecase

" 検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase

" 検索結果をハイライト
set hlsearch

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"----------------------------------------------------------
" ステータスラインの設定
"----------------------------------------------------------
" ステータスラインを常に表示
set laststatus=2

" 現在のモードを表示
set showmode

" 打ったコマンドをステータスラインの下に表示
set showcmd

" ステータスラインの右側にカーソルの現在位置を表示する
set ruler

"-----------------------------------------------------------------
" other
"-----------------------------------------------------------------
" □ や○ 文字が崩れる問題を解決
set ambiwidth=double

" 行番号を表示
set number

" TrueColorで表示
set termguicolors

" 括弧の対応関係を一瞬表示する
set showmatch

" コマンドモードの補完
set wildmenu

" 保存するコマンド履歴の数
set history=5000

" クリップボードにコピーを有効にする
if has('nvim')
    set clipboard=unnamed
else
    set clipboard=unnamed,autoselect
endif

" マウス有効化
if !has('nvim') && has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
    ¦   set ttymouse=sgr
  else
    ¦   set ttymouse=xterm2
    endif
endif

" HTMLタグを閉じる
augroup HTMLANDXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

"-----------------------------------------------------------------
" colorscheme
"-----------------------------------------------------------------
syntax on
colorscheme badwolf
highlight Normal ctermbg=none

"-----------------------------------------------------------------
" Plug
"-----------------------------------------------------------------
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'bronson/vim-trailing-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'sainnhe/gruvbox-material'

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
Plug 'dense-analysis/ale'
Plug 'skanehira/preview-markdown.vim'
call plug#end()

"-----------------------------------------------------------------
" coc.nvim
"-----------------------------------------------------------------
let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint8', 'coc-prettier', 'coc-git', 'coc-fzf-preview', 'coc-lists']

function! s:coc_typescript_settings() abort
  nnoremap <silent> <buffer> [dev]f :<C-u>CocCommand eslint.executeAutofix<CR>:CocCommand prettier.formatFile<CR>
endfunction

augroup coc_ts
  autocmd!
  autocmd FileType typescript,typescriptreact call <SID>coc_typescript_settings()
augroup END

"-----------------------------------------------------------------
" ctreesitter
"-----------------------------------------------------------------
if has('nvim')
    lua <<EOF
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        "typescript",
        "tsx",
      },
      highlight = {
        enable = true,
      },
    }
EOF
endif

"-----------------------------------------------------------------
" fzf-preview
"-----------------------------------------------------------------
let $BAT_THEME                     = 'badwolf'
let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'badwolf'
nnoremap <silent> <C-p>  :<C-u>CocCommand fzf-preview.FromResources buffer project_mru project<CR>

"-----------------------------------------------------------------
" fern
"-----------------------------------------------------------------
" leader+eで エクスプロラーを開く
nnoremap <silent> <Leader>e :<C-u>Fern . -drawer<CR>
" leader+Eで、現在のファイルの場所を開く
nnoremap <silent> <Leader>E :<C-u>Fern . -drawer -reveal=%<CR>

" ファイルのアイコンを表示
let g:fern#renderer = 'nerdfont'

" アイコンに色をつける
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

"-----------------------------------------------------------------
" ale(frontend prettier) / $ yarn add -D prettier-eslint-cli
"-----------------------------------------------------------------
let g:ale_fixers = {
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'javascript': ['prettier'],
\   'javascriptreact': ['prettier'],
\   'css': ['prettier'],
\}

" 修正箇所の表示オプション
let g:ale_sign_error = 'P>'
let g:ale_sign_warning = 'P-'
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_statusline_format = ['E%d', 'W%d', 'OK']

nmap <silent> <C-w>j <Plug>(ale_next_wrap)
nmap <silent> <C-w>k <Plug>(ale_previous_wrap)

" ファイル保存時に実行
let g:ale_fix_on_save = 1
" ローカルの設定ファイルを考慮する
let g:ale_javascript_prettier_use_local_config = 1

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

let g:preview_markdown_parser="glow"
let g:preview_markdown_vertical = 1

