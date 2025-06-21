return {
    { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}, },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' }, },
    { "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate" },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        lazy = false, 
        ---@module "neo-tree"
        ---@type neotree.Config?
        opts = {},
    }
}
