require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
local uname = vim.loop.os_uname()

_G.OS = uname.sysname
_G.IS_MAC = OS == 'Darwin'
_G.IS_LINUX = OS == 'Linux'
_G.IS_WINDOWS = OS:find 'Windows' and true or false
_G.IS_WSL = IS_LINUX and uname.release:find 'Microsoft' and true or false

if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.o.guifont = "CaskaydiaCove NFM:h12" -- text below applies for VimScript
    --vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h12"
end

if _G.IS_LINUX then
  vim.opt.shell = "fish"
elseif _G.IS_MAC then
  vim.opt.shell = "fish"
else
  vim.opt.shell = vim.fn.executable "pwsh" and "pwsh" or "powershell"
  vim.env.SHELL = "pwsh"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end
