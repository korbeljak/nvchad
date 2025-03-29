require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")


map("n", '<leader>dc', function() require('dap').continue() end, {desc="Debug - Run/Continue"})
map("n", '<leader>db', function() require('dap').toggle_breakpoint() end, {desc="Debug - Breakpoint"})
map("n", '<leader>dn', function() require('dap').step_over() end, {desc="Debug - Next"})
map("n", '<leader>ds', function() require('dap').step_into() end, {desc="Debug - Step Into"})
map("n", '<leader>do', function() require('dap').step_out() end, {desc="Debug - Step Out"})
map("n", '<leader>dq', function() require('dapui').close() end, {desc="Close dap-ui"})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
