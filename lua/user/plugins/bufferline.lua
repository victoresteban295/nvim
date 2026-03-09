return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {
        options = {
            -- mode = "tabs",
            -- separator_style = "slant",
        },
        highlights = {
            fill = { -- bufferline background color
                bg = "#112638", 
            },
            buffer_selected = { -- Current Active Buffer
                fg = "#65d1ff", 
                bold = true,
            },
        }
    },
}
