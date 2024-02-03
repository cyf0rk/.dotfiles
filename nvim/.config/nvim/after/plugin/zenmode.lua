vim.keymap.set("n", "<leader>zz", function()
    require'zen-mode'.setup {
        window = {
            width = 90,
            options = { }
        },
        plugins = {
            wezterm = {
              enabled = false,
              -- can be either an absolute font size or the number of incremental steps
              font = "+2", -- (10% increase per step)
            }
        }
    }
    require'zen-mode'.toggle()
    forkPencils()
end)


vim.keymap.set("n", "<leader>zZ", function()
    require'zen-mode'.setup {
        window = {
            width = 80,
            options = { }
        },
    }
    require'zen-mode'.toggle()
    forkPencils()
end)
