lua << EOF
  -- lua require('init')
EOF
"plug autoinstaller
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin( !empty($VIM_PLUGGED) ? $VIM_PLUGGED : "~/.vim/plugged" )
  " The default plugin directory will be as follows:
  "   - Vim (Linux/macOS): '~/.vim/plugged'
  "   - Vim (Windows): '~/vimfiles/plugged'
  "   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
  " You can specify a custom plugin directory by passing it as the argument
  "   - e.g. `call plug#begin('~/.vim/plugged')`
  "   - Avoid using standard Vim directory names like 'plugin'

  " Make sure you use single quotes

  " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align

  Plug 'elixir-editors/vim-elixir'

  " Use release branch (recommend)
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'sheerun/vim-polyglot', {'branch':'master'}

  Plug 'mhinz/vim-mix-format'

  Plug 'kaicataldo/material.vim', { 'branch': 'main' }

  Plug 'tpope/vim-fugitive'

  Plug 'psf/black', { 'branch': 'stable' }

  Plug 'tomlion/vim-solidity'

  Plug 'neovim/nvim-lspconfig'

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  Plug 'junegunn/fzf.vim'

  Plug 'LnL7/vim-nix'

  Plug 'vim-airline/vim-airline'

  Plug 'vim-airline/vim-airline-themes'

  Plug 'jiangmiao/auto-pairs', { 'branch':'master' }

  Plug 'tpope/vim-surround', { 'branch':'master' }

  Plug 'tpope/vim-repeat', { 'branch':'master' }
  
  Plug 'qiuxiang/coc-solidity'

  Plug  'istepura/vim-toolbar-icons-silk'
  
  "https://www.reddit.com/r/vim/comments/bfq2zi/comment/elgo5h0/?utm_source=share&utm_medium=web2x&context=3
  Plug 'godlygeek/tabular'

  Plug 'preservim/vim-markdown'

  Plug 'junegunn/goyo.vim'

  Plug 'preservim/vim-pencil'

  Plug 'junegunn/limelight.vim'

  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

  Plug 'tpope/vim-commentary'

  Plug 'preservim/nerdtree'

  Plug 'ryanoasis/vim-devicons'
call plug#end()

"keybinds

" https://vimways.org/2019/vim-and-the-working-directory/ cite your sources
" 'cd' towards the directory in which the current file is edited
" but only change the path for the current window
nnoremap <leader>cd :lcd %:h<CR>

"Tama McGlinn's comment on Primagen's channel https://www.youtube.com/watch?v=hJzqEAf2U4I
nnoremap <leader>ex :!chmod +x %<CR>

" https://github.com/dowlandaiello/dotfiles/blob/master/.config/nvim/init.vim
noremap <leader>s H
noremap <leader>S L
map L $
map H ^

" https://vi.stackexchange.com/questions/2129/fastest-way-to-switch-to-a-buffer-in-vim
nnoremap <leader>b :ls<CR>:b<Space>

" https://vim.fandom.com/wiki/Fix_indentation
map <leader>i gg=G``

" my stuff
map <leader>l o<C-[>
map <leader>L O<C-[>
map <leader>p <leader>lgP
map <leader>P <leader>LP
map <leader>ya gg"+yG``

nnoremap <leader>ew :noh<CR>

nnoremap <C-]> :FZF<CR>

nnoremap + :NERDTree<CR>


nnoremap <leader>fo :Format<CR>

"usually for parentheses, might add more wordwise shortcuts
inoremap <M-d> <C-O>x

" https://secluded.site/vim-as-a-markdown-editor/#goyo
nnoremap <C-g> :Goyo<CR>
" autocmd FileType markdown Goyo

"nnoremap <C-x> :bd<CR>
nnoremap <C-x> :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <C-o> :bp<CR>
nnoremap <C-p> :bn<CR>

" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has('termguicolors'))
  set termguicolors
endif

let g:material_theme_style = 'ocean'

let g:material_terminal_italics = 1
colorscheme material

"plugins and configs
" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

"netrw from https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_bufsettings = 'noshowmode number relativenumberhi LineNr guifg=#ffffff'


set nofoldenable
" Configuration for vim-markdown
" https://secluded.site/vim-as-a-markdown-editor/#vim-markdown
let g:vim_markdown_conceal = 2
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_edit_url_in = 'tab'
let g:vim_markdown_follow_anchor = 1
let g:mkdp_echo_preview_url = 1

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
function! Firefox_window(ip)
  silent execute '!firefox' '--new-window' a:ip
endfunction

let g:mkdp_browserfunc = 'Firefox_window'
function! s:aesthetics()
  set expandtab
  set linebreak
  set autoindent
  set breakindent
  set cindent
  syntax enable
  filetype plugin indent on

  " aesthetics
  set noshowmode
  set number relativenumber
  hi LineNr guifg=#ffffff
  set pumheight=12

  " May need for vim (not neovim) since coc.nvim calculate byte offset by count
  " utf-8 byte sequence.
  set encoding=utf-8
  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes
  if (has('gui')) "breaks for reg vim
    highlight Cursor guibg=lightgrey guifg=black
    set guicursor=i:ver20-Cursor 
    set guicursor+=n-ci:Cursor
    set guifont=Inconsolata\ 13
  endif
  
  "https://secluded.site/vim-as-a-markdown-editor/#general-vim-things
  " Keep cursor in approximately the middle of the screen
  set scrolloff=12

  " Disable mouse support
  set mouse=
endfunction

call s:aesthetics()

function! s:goyo_enter()
  Limelight
  set showmode

  noremap j gj
  noremap k gk
  " decided against remapping H to 0 for now

  SoftPencil
  set nobreakindent
  set noautoindent
endfunction

function! s:goyo_leave()
  PencilOff
  call s:aesthetics()
  unmap j
  unmap k
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"https://github.com/ds26gte/scmindent
if executable('scmindent') && executable('racket')
  autocmd filetype lisp,scheme setlocal equalprg=scmindent
endif


function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" \"suggest.noselect": true " in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> g] :call CocAction('diagnosticNext')<CR>
nmap <silent> g[ :call CocAction('diagnosticPrev')<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-k>'
let g:coc_snippet_prev = '<c-j>'
