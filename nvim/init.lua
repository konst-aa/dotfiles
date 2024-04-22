-- and so it begins...


local data_dir = vim.fn.stdpath("data") .. "/site"
local set = vim.opt

if vim.fn.empty(data_dir .. "/pack") then
    os.execute('git clone --depth=1 https://github.com/savq/paq-nvim.git ' .. data_dir .. '/pack/paqs/start/paq-nvim')
end

require("paq") {
    "kaicataldo/material.vim",
    "tpope/vim-fugitive",
    "neovim/nvim-lspconfig",
    "nvim-lualine/lualine.nvim",
    "jiangmiao/auto-pairs",
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "istepura/vim-toolbar-icons-silk",
    "preservim/vim-markdown",
    "junegunn/goyo.vim",
    "preservim/vim-pencil",
    "junegunn/limelight.vim",
    {
        "iamcco/markdown-preview.nvim",
        build = "yarn install"
    },
    "tpope/vim-commentary",
    "preservim/nerdtree",
    "ryanoasis/vim-devicons",
    {
        "neoclide/coc.nvim",
        build = "yarn install"
    },
    "LnL7/vim-nix",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "neovimhaskell/haskell-vim",
    "justinmk/vim-sneak",
    "github/copilot.vim",
    "OmniSharp/omnisharp-vim",
    "junegunn/vim-easy-align",
    "vimwiki/vimwiki",
}

vim.g.coc_global_extensions = {
    "coc-json",
    "coc-git",
    "coc-lua",
    "coc-pyright",
    "coc-clangd"
}
local builtin = require('telescope.builtin')
require("coc")
require("line")
require("align")
require("wiki")

-- keybinds
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

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

if vim.fn.executable('scmindent') + vim.fn.executable('racket') == 2 then
    vim.cmd "autocmd filetype lisp,scheme setlocal equalprg=scmindent"
end

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  desc = 'Set filetype for SSH config directories',
  pattern = { '/etc/ssh/config.d/*', '*/.ssh/*config*' },
  command = 'set filetype=sshconfig'
})

if vim.fn.has("termguicolors") then
    vim.opt.termguicolors = true
end

vim.cmd "set nofoldenable"

vim.g["material_theme_style"] = "ocean"
vim.g["material_terminal_italics"] = 1
vim.cmd "colorscheme material"

vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail_improved"

local function aesthetics()
    set.expandtab = true
    set.linebreak = true
    set.autoindent = true
    set.breakindent = true
    set.cindent = true
    set.shiftwidth = 4
    set.tabstop = 4

    vim.cmd "let NERDTreeShowLineNumbers=1"
    vim.cmd "autocmd FileType nerdtree setlocal relativenumber"
    -- vim.cmd "autocmd FileType haskell setlocal shiftwidth=2 tabstop=2"
    vim.cmd "syntax enable"
    vim.cmd "filetype plugin indent on"

    -- aesthetics
    vim.cmd "set noshowmode"
    vim.wo.number = true
    vim.wo.relativenumber = true
    vim.cmd "hi LineNr guifg=#ffffff"

    set.pumheight = 12

    -- May need for vim (not neovim) since coc.nvim calculate byte offset by count
    -- utf-8 byte sequence.
    set.encoding = "utf-8"

    -- Some servers have issues with backup files, see #649.
    vim.cmd "set nobackup"
    vim.cmd "set nowritebackup"

    --  Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    -- delays and poor user experience.
    set.updatetime = 300

    -- Always show the signcolumn, otherwise it would shift the text each time
    -- diagnostics appear/become resolved.
    set.signcolumn = "yes"

    -- https://secluded.site/vim-as-a-markdown-editor/#general-vim-things
    -- Keep cursor in approximately the middle of the screen
    set.scrolloff = 12
end

local function goyo_enter()
    vim.cmd "Limelight"
    vim.cmd "set showmode"

    -- decided against remapping H to 0 for now

    vim.cmd "SoftPencil"
    vim.cmd "set nobreakindent"
    vim.cmd "set noautoindent"
    require('lualine').hide()
end

local function goyo_leave()
    vim.cmd "PencilOff"
    aesthetics()
    vim.cmd "Limelight!"
    require('lualine').hide({ unhide = true })
end

vim.api.nvim_create_autocmd("User", { pattern = "GoyoEnter", callback = goyo_enter })
vim.api.nvim_create_autocmd("User", { pattern = "GoyoLeave", callback = goyo_leave })
-- vim.cmd([[
-- autocmd! User GoyoEnter nested :lua goyo_enter()
-- autocmd! User GoyoLeave nested :lua goyo_leave()
-- ]])

aesthetics()
