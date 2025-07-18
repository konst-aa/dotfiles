-- and so it begins...


local data_dir = vim.fn.stdpath("data") .. "/site"
local set = vim.opt

local haspaq,_ = pcall(require,"paq")
if not haspaq then
    os.execute('git clone --depth=1 https://github.com/savq/paq-nvim.git ' .. data_dir .. '/pack/paqs/start/paq-nvim')
end

require("paq") {
    "williamboman/mason.nvim",
    "kaicataldo/material.vim",
    "tpope/vim-fugitive",
    "neovim/nvim-lspconfig",
    "nvim-lualine/lualine.nvim",
    -- "jiangmiao/auto-pairs",
    "windwp/nvim-autopairs",
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "istepura/vim-toolbar-icons-silk",
    "godlygeek/tabular",
    "preservim/vim-markdown",
    "junegunn/goyo.vim",
    "preservim/vim-pencil",
    "junegunn/limelight.vim",
     -- {
     --     "neoclide/coc.nvim",
     --     build = "npm ci",
     -- },
    "tpope/vim-commentary",
    "preservim/nerdtree",
    "ryanoasis/vim-devicons",
    "LnL7/vim-nix",
    -- "nvim-telescope/telescope.nvim",
    "folke/snacks",
    "nvim-lua/plenary.nvim",
    "neovimhaskell/haskell-vim",
    "justinmk/vim-sneak",
    "OmniSharp/omnisharp-vim",
    "junegunn/vim-easy-align",
    -- "konst-aa/luawiki",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "romgrk/barbar.nvim",
    "yetone/avante.nvim",
    "MunifTanjim/nui.nvim",
    "zbirenbaum/copilot.lua",
     "Plabrum/org-markdown"

    -- "jls83/vimwiki", -- 43 commits behind as of May 2024
}


-- vim.env.FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'


-- local lspconfig = require('lspconfig')
require("my-lsps")

-- require("notion")
-- require("my-conqueror")
-- require("line")
require("align")
require("nvim-autopairs").setup {}
-- require("luawiki").setup {}
require("action-tags")
require("copilot").setup({
  suggestion = {
    auto_trigger = false, -- disables automatic suggestions
    keymap = {
      accept = "<C-H>", -- manually trigger and accept suggestion
      next = "<C-J>",
      prev = "<C-K>",
      dismiss = "<C-L>",
    },
  },
  panel = { enabled = false },
})
require("avante").setup {
provider = "copilot",
}

require("org_markdown").setup {
  keymaps = {
    capture = "<leader>on",
    agenda = "<leader>ov",
    find_file = "<leader>of",
    refile_to_file = "<leader>or",
  },
  picker = "telescope", -- or "snacks"
  window_method = "float", -- or "horizontal"
  captures = {
    default_template = "inbox",
    templates = {
      inbox = {
        file = "~/notes/inbox.md",
        heading = "Inbox",
        template = "- [ ] %t %?",
      },
    },
}
}


-- require("mylspconfig")

-- vim.g.coc_global_extensions = {
--     "coc-json",
--     "coc-git",
--     "coc-lua",
--     "coc-pyright",
--     "coc-clangd"
-- }


require("my-treesitter")
require("my-telescope")
require("my-barbar")



require("line")
require("align")
-- require("luawiki").setup {}


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


vim.api.nvim_create_user_command("Resource",function()
  pcall(function()
      vim.cmd "source $MYVIMRC"
  end)
end,{})


-- will need to figure out how to do lazy loading
vim.api.nvim_create_user_command("Loadpilot",function()
  pcall(function()
      packadd("copilot.vim")
      vim.cmd "Copilot enable"
      -- vim.cmd "source $MYVIMRC"
  end)
end,{})

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

vim.cmd "nnoremap <C-]> :FZF<CR>"

vim.cmd "nnoremap + :NERDTreeToggle<CR>"

vim.cmd "nnoremap <leader>fo :Format<CR>"

-- usually for parentheses, might add more wordwise shortcuts
vim.cmd "inoremap <M-d> <C-O>x"

-- https://secluded.site/vim-as-a-markdown-editor/#goyo
vim.cmd "nnoremap <C-g> :Goyo<CR>"

-- nnoremap <C-x> :bd<CR>
vim.cmd "nnoremap <C-x> :BufferClose<CR>"
vim.cmd "nnoremap <C-l> :BufferNext<CR>"
vim.cmd "nnoremap <C-h> :BufferPrevious<CR>"

vim.cmd "nnoremap <C-j> :cnext<cr>"
vim.cmd "nnoremap <C-k> :cprev<cr>"

if vim.fn.executable('scmindent') + vim.fn.executable('racket') == 2 then
    vim.cmd "autocmd filetype lisp,scheme setlocal equalprg=scmindent"
end

if vim.fn.executable('clang-format') + vim.fn.executable('clang-format-wrapper') then
    vim.cmd("autocmd FileType c,h,cpp,hpp,objc,objc++ :setlocal formatprg=clang-format-wrapper")
end

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    desc = 'Set filetype for SSH config directories',
    pattern = { '/etc/ssh/config.d/*', '*/.ssh/*config*' },
    command = 'set filetype=sshconfig'
})

-- this thing sucks; not the plugin, but Copilot.
-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--         vim.cmd "Copilot disable"
--    end,
-- })

if vim.fn.has("termguicolors") then
    vim.opt.termguicolors = true
end

vim.cmd "set nofoldenable"

vim.g["material_theme_style"] = "ocean"
vim.g["material_terminal_italics"] = 1
vim.cmd "colorscheme material"

-- vim.g["airline#extensions#tabline#formatter"] = "unique_tail_improved"

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
    -- Auto-resize windows when Neovim is resized
    vim.api.nvim_create_autocmd("VimResized", {
      pattern = "*",
      command = "wincmd =",
    })

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

    vim.cmd "noremap j gj"
    vim.cmd "noremap k gk"
    vim.cmd "SoftPencil"
    vim.cmd "set nobreakindent"
    vim.cmd "set noautoindent"
    vim.cmd "setlocal spell spelllang=en_us"
    require('lualine').hide()

    
end

local function goyo_leave()
    vim.cmd "unmap j"
    vim.cmd "unmap k"
    vim.cmd "PencilOff"
    aesthetics()
    vim.cmd "Limelight!"
    require('lualine').hide({ unhide = true })
end

vim.api.nvim_create_autocmd("User", { pattern = "GoyoEnter", callback = goyo_enter })
vim.api.nvim_create_autocmd("User", { pattern = "GoyoLeave", callback = goyo_leave })

-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = 'markdown',
--     callback = function()
--         vim.opt_local.autoindent = false
--         vim.opt_local.smartindent = false
--         vim.opt_local.cindent = false
--     end
-- })

aesthetics()

