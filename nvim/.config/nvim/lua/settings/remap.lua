-- netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- helps with copilot in normal mode and some block selections stuff
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Moving text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Keeping it centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Copy-paste-delete
vim.keymap.set("x", "<leader>P", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

-- Undo break points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "[", "[<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")
vim.keymap.set("i", ":", ":<c-g>u")

-- Move errors
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace word under cursor
vim.keymap.set(
    "n",
    "<leader>s",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>"
)

-- Make copy of current file
vim.keymap.set(
    "n",
    "<leader>mc",
    ":silent exec \"!cp '%:p' '%:p:h/%:t:r-copy.%:e'\""
)

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
