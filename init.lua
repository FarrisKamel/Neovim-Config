-- Install Lazy nvim, the plugin manager
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


local opts = {}

require("vim-configs")
require("lazy").setup("plugins")



-- Everything below is used for colorshemes
require("solarized-osaka").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) end,

    on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
            bg = prompt,
        }
        hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePreviewTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
    end,
})

-- Setup for kanagawa color scheme
-- require('kanagawa').setup({
--    compile = false,             -- enable compiling the colorscheme
--    undercurl = true,            -- enable undercurls
--    commentStyle = { italic = true },
--    functionStyle = {},
--    keywordStyle = { italic = true},
--    statementStyle = { bold = true },
--    typeStyle = {},
--    transparent = false,         -- do not set background color
--    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
--    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
--    colors = {                   -- add/modify theme and palette colors
--       palette = {},
--        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
--    },
--    overrides = function(colors) -- add/modify highlights
--        return {}
--    end,
--    theme = "wave",              -- Load "wave" theme when 'background' option is not set
--    background = {               -- map the value of 'background' option to a theme
--        dark = "wave",           -- try "dragon" !
--        light = "lotus"
--    },
--})

vim.cmd.colorscheme "solarized-osaka"
