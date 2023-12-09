--local color = 'tokyonight'

function forkPencils()
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_transparent = true
    vim.opt.background = 'dark'

    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    local hl = function(thing, opts)
        vim.api.nvim_set_hl(0, thing, opts)
    end

    hl('Normal', {
        bg = "none"
    })

    hl('NormalFloat', {
        bg = "none"
    })

end
forkPencils()
