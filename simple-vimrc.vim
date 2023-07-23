"barebones, no lsp, no plug, just indentation and a bit of convenience

syntax off
set number relativenumber
set nu rnu
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smartindent

"//github.com/dowlandaiello/dotfiles/blob/master/.config/nvim/init.vim
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

nnoremap <leader>of :syntax off<CR>
nnoremap <leader>on :syntax on<CR>
