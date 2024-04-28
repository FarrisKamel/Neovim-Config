return{
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", 
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    -- Neo Tree KeyMap
    vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal float<CR>', {}),

    config = function() 
        require("neo-tree").setup({
            window = { position = "right" },
            event_handlers = {

                {
                    event = "file_opened",
                    handler = function(file_path)
                        -- auto close
                        -- vimc.cmd("Neotree close")
                        -- OR
                        require("neo-tree.command").execute({ action = "close" })
                    end
                },

            }
        })
    end
}
