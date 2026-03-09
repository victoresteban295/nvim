-- LSP Configuration 
return {
    {
        -- Package Manager for LSP
        -- Provides UI to install LSP servers and more
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },

    -- ****************************************************************
    -- ****************************************************************
    -- ****************************************************************

    {
        -- Connects mason.nvim plugin + lspconfig plugin
        -- provides ensure_installed functionality
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",           -- Lua
                    "vtsls",            -- TypeScript/JavaScript
                    "pyright",          -- Python
                    "jdtls",            -- Java
                    "html", "cssls", "jsonls", -- Web
                },
            })
        end
    },

    -- ****************************************************************
    -- ****************************************************************
    -- ****************************************************************

    {
        -- Enables Neovim to Communicate with LSP Servers
        -- Add configurations to neovim 
        -- Custom keymaps functionality
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()

            -- capabilities tells LSP servers what nvim-cmp supports
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- ******************************************************* --
            -- Common on_attach: keymaps & inlay hints if available
            -- ******************************************************* --
            local on_attach = function(client, bufnr)
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
                end

                -- set keybinds
                map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references") -- show definition, references
                map("n", "gD", vim.lsp.buf.declaration, "Go to declaration") -- go to declaration
                map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions") -- show lsp definitions
                map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations") -- show lsp implementations
                map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions") -- show lsp type definitions
                map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions") -- see available code actions, in visual mode will apply to selection
                map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename") -- smart rename
                map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics") -- show  diagnostics for file
                map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics") -- show diagnostics for line
                map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic") -- jump to previous diagnostic in buffer
                map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic") -- jump to next diagnostic in buffer
                map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor") -- show documentation for what is under cursor
                map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP") -- mapping to restart lsp if necessary
                if vim.lsp.inlay_hint then pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr }) end
            end

            -- ************************************************************ --
            -- Change the Diagnostic symbols in the sign column (gutter)
            -- ************************************************************ --
            vim.diagnostic.config({
                virtual_text = {
                    -- Enable inline messages
                    source = "always", -- show source (e.g. "eslint") in the message
                    -- prefix = function(diagnostic)
                    --     return icons[diagnostic.severity] or "●"
                    -- end,
                    prefix = " ●",
                    spacing = 2,       -- spacing between text and message
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = "󰠠 ",
                        [vim.diagnostic.severity.INFO] = " ",
                    },
                },
            })

            -- ****************************** --
            -- Add Each LSP Server to Use
            -- ****************************** --
            local lspconfig = require("lspconfig")

            -- Lua
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                        hint = { enable = true },
                    },
                },
            })

            -- JavaScript / TypeScript
            lspconfig.vtsls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    vtsls = { experimental = { completion = { enableServerSideFuzzyMatch = true } } },
                    typescript = { inlayHints = { parameterNames = { enabled = "all" }, variableTypes = { enabled = true } } },
                    javascript = { inlayHints = { parameterNames = { enabled = "all" } } },
                },
            })

            -- Python
            lspconfig.pyright.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })

            -- HTML / CSS / JSON
            lspconfig.html.setup({ on_attach = on_attach, capabilities = capabilities })
            lspconfig.cssls.setup({ on_attach = on_attach, capabilities = capabilities })
            lspconfig.jsonls.setup({ on_attach = on_attach, capabilities = capabilities })

            -- NOTE: Java (jdtls) is handled by plugins/lsp/java.lua via nvim-jdtls

        end
    },
}
