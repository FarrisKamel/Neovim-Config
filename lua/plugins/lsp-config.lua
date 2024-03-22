return {
    {
        'folke/neodev.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local neodev_status_ok, neodev = pcall(require, 'neodev')

            if not neodev_status_ok then
                return
            end

            neodev.setup()
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        cmd = 'Mason',
        branch = 'v2.x',
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end
            },
            { 'williamboman/mason-lspconfig.nvim', },

            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
            { 'SmiteshP/nvim-navic' }
        },
        config = function()

            local lsp = require('lsp-zero').preset({})

            local navic = require('nvim-navic')

            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({buffer = bufnr})
                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end
            end)

            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

            lsp.ensure_installed({
                'pyright',
                'lua_ls',
                'gopls',
                'clangd',
                'html',
                'tsserver'
            })

            lsp.setup()

            local cmp = require('cmp')
            -- local cmp_action = require('lsp-zero').cmp_action()

            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
                preselect = cmp.PreselectMode.None,
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                },
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                }
            })

        end
    },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'rafamadriz/friendly-snippets' },
    -- {
    --     'dgagn/diagflow.nvim',
    --     opts = {
    --         -- placement = 'inline',
    --         scope = 'line',
    --         padding_right = 5
    --     }
    -- }
}

-- return {
--     {
--         -- Mason used to mangae all the LSPs
--         "williamboman/mason.nvim",
--         config = function()
--             require("mason").setup()
--         end
--     },
--     {
--         -- Used to help with the Language Server Protocol configs
--         "williamboman/mason-lspconfig.nvim",
--         config = function()
--             require("mason-lspconfig").setup({
--                 -- LSPs downloaded 
--                 ensure_installed = {"html", "lua_ls", "tsserver", "pyright" }
--             })
--         end
--     },
--     {
--         'WhoIsSethDaniel/mason-tool-installer.nvim',
--         config = function()
--             require('mason-tool-installer').setup({
--                 ensure_installed = {
--                     'black',
--                     'debugpy',
--                     'flake8',
--                     'isort',
--                     'mypy',
--                     'pylint',
--                 },
--             })
--         end
--     },
--     {
--         -- Used to implement the lsp in nvim
--         "neovim/nvim-lspconfig",
--         config = function ()
--             local capabilities = require('cmp_nvim_lsp').default_capabilities()
--             local lspconfig = require("lspconfig")
-- 
--             lspconfig.lua_ls.setup({ capabilities = capabilities })
--             lspconfig.tsserver.setup({capabilities = capabilities})
--             lspconfig.pyright.setup({
--                 on_attach = on_attach,
--                 capabilities = capabilities})
-- 
--             vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
--             vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
--             vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
--             vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
--             vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
--         end
--     }
-- }