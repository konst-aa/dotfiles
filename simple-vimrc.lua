local data_dir = vim.fn.stdpath("data") .. "/site"
local set = vim.opt

if vim.fn.empty(data_dir .. "/pack") then
    os.execute('git clone --depth=1 https://github.com/savq/paq-nvim.git ' .. data_dir .. '/pack/paqs/start/paq-nvim')
end


require("paq") {
    "konst-aa/luawiki",
}

-- keybinds

-- EasyAlign
vim.cmd "nmap ga <Plug>(EasyAlign)"
vim.cmd "xmap ga <Plug>(EasyAlign)"

-- Tama McGlinn's comment on Primagen's channel https://www.youtube.com/watch?v=hJzqEAf2U4I
vim.cmd "nnoremap <leader>ex :!chmod +x %<CR>"

-- https://github.com/dowlandaiello/dotfiles/blob/master/.config/nvim/init.vim
vim.cmd "noremap <leader>s H"
vim.cmd "noremap <leader>S L"
vim.cmd "map L $"
vim.cmd "map H ^"

-- https://vi.stackexchange.com/questions/2129/fastest-way-to-switch-to-a-buffer-in-vim
vim.cmd "nnoremap <leader>b :ls<CR>:b<Space>"

-- https://vim.fandom.com/wiki/Fix_indentation
vim.cmd "map <leader>i gg=G``"

-- my stuff
vim.cmd "map <leader>l o<C-[>"
vim.cmd "map <leader>L O<C-[>"
vim.cmd "map <leader>p <leader>lgP"
vim.cmd "map <leader>P <leader>LP"
vim.cmd "map <leader>ya gg\"+yG``"
vim.cmd "map <leader>go :Copilot enable<CR>"
vim.cmd "map <leader>gf :Copilot disable<CR>"
vim.cmd "map <leader>day :Day<CR>"
vim.cmd "map <leader>tm :Time<CR>"

vim.cmd "nnoremap <leader>ew :noh<CR>"

vim.cmd "nnoremap <C-]> :FZF<CR>"

vim.cmd "nnoremap + :NERDTree<CR>"

vim.cmd "nnoremap <leader>fo :Format<CR>"

-- usually for parentheses, might add more wordwise shortcuts
vim.cmd "inoremap <M-d> <C-O>x"

-- https://secluded.site/vim-as-a-markdown-editor/#goyo
vim.cmd "nnoremap <C-g> :Goyo<CR>"

-- nnoremap <C-x> :bd<CR>
vim.cmd "nnoremap <C-x> :bp<bar>sp<bar>bn<bar>bd<CR>"
vim.cmd "nnoremap <C-o> :bp<CR>"
vim.cmd "nnoremap <C-p> :bn<CR>"

vim.cmd "noremap j gj"
vim.cmd "noremap k gk"

vim.api.nvim_create_user_command("Day",function()
  pcall(function()
      vim.cmd "normal! o##"
      vim.cmd "r!date +\\%F"
      vim.cmd "normal! kJ" -- I know gJ is a thing
      vim.cmd "r!date +\"\\%a \\%d \\%b \\%Y \\%R \\%Z\""
      vim.cmd "normal! o"
      vim.cmd "normal! o"
  end)
end,{})

vim.api.nvim_create_user_command("Time",function()
  pcall(function()
      vim.cmd "normal! o###"
      vim.cmd "r!date +\"\\%H:\\%M:\\%S\""
      vim.cmd "normal! kJ"
      vim.cmd "normal! o"
  end)
end,{})

vim.cmd "nnoremap <leader>ew :noh<CR>"

