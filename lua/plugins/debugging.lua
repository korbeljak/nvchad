return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		
		dapui.setup()
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
		
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
		
		dap.configurations.rust = {
			codelldb -- different debuggers or more configurations can be used here
		}
		
		dap.configurations.cpp = {
			codelldb -- different debuggers or more configurations can be used here
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
	end,
}