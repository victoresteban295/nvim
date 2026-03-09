-- Java LSP via nvim-jdtls
-- jdtls must be installed via Mason (:MasonInstall jdtls)
return {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
        local jdtls = require("jdtls")

        local function get_jdtls_config()
            local mason_data = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
            local launcher = vim.fn.glob(mason_data .. "/plugins/org.eclipse.equinox.launcher_*.jar")

            -- Detect OS for the jdtls config directory
            local os_config
            if vim.fn.has("mac") == 1 then
                os_config = "mac"
            elseif vim.fn.has("win32") == 1 then
                os_config = "win"
            else
                os_config = "linux"
            end

            -- Unique workspace per project root
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

            return {
                cmd = {
                    "java",
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true",
                    "-Dlog.level=ALL",
                    "-Xmx1g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens", "java.base/java.util=ALL-UNNAMED",
                    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                    "-jar", launcher,
                    "-configuration", mason_data .. "/config_" .. os_config,
                    "-data", workspace_dir,
                },

                root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

                capabilities = require("cmp_nvim_lsp").default_capabilities(),

                settings = {
                    java = {
                        signatureHelp = { enabled = true },
                        inlayHints = { parameterNames = { enabled = "all" } },
                        contentProvider = { preferred = "fernflower" },
                        sources = {
                            organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
                        },
                    },
                },

                on_attach = function(client, bufnr)
                    -- Java-specific keymaps (in addition to the shared LSP keymaps)
                    local map = function(lhs, rhs, desc)
                        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
                    end

                    map("gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
                    map("gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("gd", "<cmd>Telescope lsp_definitions<CR>", "Show LSP definitions")
                    map("gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code actions")
                    map("<leader>rn", vim.lsp.buf.rename, "Smart rename")
                    map("<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
                    map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
                    map("]d", vim.diagnostic.goto_next, "Next diagnostic")
                    map("K", vim.lsp.buf.hover, "Show documentation")
                    map("<leader>rs", ":LspRestart<CR>", "Restart LSP")

                    -- Java-specific extras
                    map("<leader>jo", jdtls.organize_imports, "Organize imports")
                    map("<leader>jv", jdtls.extract_variable, "Extract variable")
                    map("<leader>jc", jdtls.extract_constant, "Extract constant")
                    map("<leader>jm", jdtls.extract_method, "Extract method")

                    if vim.lsp.inlay_hint then
                        pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
                    end
                end,
            }
        end

        -- Attach jdtls whenever a Java file is opened
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                jdtls.start_or_attach(get_jdtls_config())
            end,
        })
    end,
}
