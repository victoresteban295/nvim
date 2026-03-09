return {
    "EdenEast/nightfox.nvim", -- Colorscheme NighFox
    priority = 1000,
    config = function ()
        local theme = "nightfox"
        local colorscheme = require(theme)  

        colorscheme.setup({
            options = {
                transparent = true,
                styles = {
                    keywords = 'bold',
                }
            }
        })

        local status_ok, _ = pcall(vim.cmd, "colorscheme " .. theme)
        if not status_ok then 
            vim.notify("colorscheme " .. theme .. " not found!")
            return
        end

    end
}
