local home = os.getenv('HOME')
local dappython = require("dap-python")

dappython.setup(home .. "/.virtualenvs/debugpy/bin/python")
