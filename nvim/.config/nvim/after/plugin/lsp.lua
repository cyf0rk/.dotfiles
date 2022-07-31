local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function()
            Nnoremap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
            Nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
            Nnoremap("<leader>vd", "<cmd>lua vim.diagnostic.open_float()<CR>")
            Nnoremap("[d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
            Nnoremap("]d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
            Nnoremap("<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
            Nnoremap("<leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>")
            Nnoremap("<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>")
        end,
    }, _config or {})
end

require("lspconfig").tsserver.setup(config())

require("lspconfig").cssls.setup(config())

require("lspconfig").html.setup(config())

require("lspconfig").emmet_ls.setup(config())

require("lspconfig").pyright.setup(config())
