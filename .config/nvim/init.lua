require("chaskell")

-- Bootstrap lazy if needed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Add lazy packages
require("lazy").setup({
    {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { "catppuccin/nvim",                  name = "catppuccin", priority = 1000 },
    { "folke/trouble.nvim" },
    { "nvim-treesitter/nvim-treesitter",  build = ":TSUpdate" },
    { "ThePrimeagen/harpoon" },
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'lewis6991/gitsigns.nvim' },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp"
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    { 'rafamadriz/friendly-snippets' },
    { 'jose-elias-alvarez/null-ls.nvim' },
    { 'MunifTanjim/prettier.nvim' },
})
