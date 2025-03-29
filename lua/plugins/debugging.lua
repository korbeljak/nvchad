return {
	"mfussenegger/nvim-dap",
  dependencies = {
	  "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
  },
	config = function()
		local dap = require("dap")
    local dappy = require("dap-python")
		local dapui = require("dapui")
    dappy.setup()
		dapui.setup()
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		  dap.set_exception_breakpoints({"uncaught"})
		end

		dap.listeners.before.event_terminated.dapui_config = function()
			--dapui.close()
		end
		
		dap.listeners.before.event_exited.dapui_config = function()
			--dapui.close()
		end

    -- Python
    --
    --local python_dap = require()
		-- C
		local home_path = "C:\\Users\\JKorbel"
		local vscode_path = home_path .. "\\scoop\\apps\\vscode"
		local lldb_ext_path = vscode_path .. "\\current\\data\\extensions\\vadimcn.vscode-lldb-1.11.2"
		
		local lldb_exe_path = lldb_ext_path .. "\\lldb\\bin\\lldb.exe"
		local lldb_lib_path = lldb_ext_path .. "\\lldb\\bin\\liblldb.dll"
		local lldb_adapter_exe_path = lldb_ext_path .. "\\adapter\\codelldb.exe"
		
		local lldb_port = "13000"
		dap.adapters.codelldb = {
			type = "server",
			port = lldb_port,
			host = "127.0.0.1",
			executable = {
				command=lldb_adapter_exe_path,
				args= {"--port", lldb_port, "--liblldb", lldb_lib_path}
			},
			
			name = "codelldb",
		}

		dap.configurations.c = {
			{
				name = "EDLT - C",
				type = "codelldb",
				request = "launch",
				program = "C:\\Users\\JKorbel\\prj\\edlt\\bld\\win\\Debug\\proj_windows.exe",
				args = {"127.0.0.1"},
				cwd = "C:\\Users\\JKorbel\\prj\\edlt\\bld\\win",
				stopOnEntry=true,
				runInTerminal=true,
			},
		}

    dappy.setup("python")
    table.insert(require('dap').configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'Jedi',
      program = '${file}',
      args = {"--eds-path", "C:\\Users\\JKorbel\\Downloads\\EDS.eds"},
      cwd = "C:\\Users\\JKorbel\\Downloads",
  -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
})
    -- dap.configurations.python = {
    --   {
    --     name = 'Jedi - Python',
    --     type = "python",
    --     request = 'launch',
    --     program = 'C:\\Users\\JKorbel\\gitlab\\jedi\\src\\jedi.py',
    --     args = {"--eds-file", "C:\\Users\\JKorbel\\Downloads\\EDS.eds"},
    --     cwd = "C:\\Users\\JKorbel\\prj\\edlt\\win",
    --   },
    -- }
	end,

}
