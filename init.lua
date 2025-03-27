vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "
vim.api.nvim_set_option("clipboard", "unnamedplus")

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

-- Function to insert a function doc header
function InsertFunctionDoc()
  local lines = {
    "//" .. string.rep("-",80-2),
    "///",
    "/// @brief ",
    "///",
    "/// @param[in] ",
    "///",
    "/// @param[out] ",
    "///",
    "/// @param[in,out] ",
    "///",
    "/// @return ",
    "/// @retval ",
    "///",
    "//" .. string.rep("-",80-2)
  }
  
  vim.api.nvim_put(lines, 'l', true, false)
end

-- Map the macro to a key combination, e.g., <leader>d
vim.api.nvim_set_keymap('n', '<leader>doc', ':lua InsertFunctionDoc()<CR>', { noremap = true, silent = true } )

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
