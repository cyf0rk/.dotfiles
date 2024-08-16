return {
  -- go
  'ray-x/go.nvim',
  'ray-x/guihua.lua',
  config = function()
    require('go').setup()
  end
}
