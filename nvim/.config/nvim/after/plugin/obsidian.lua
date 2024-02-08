local obsidian = require'obsidian'

obsidian.setup({
    workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
    }
})
