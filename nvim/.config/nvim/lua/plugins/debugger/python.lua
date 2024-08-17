return {
	"mfussenegger/nvim-dap-python",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	config = function()
    local dappython = require'dap-python'
    dappython.setup("/usr/bin/python")
	end,
}
