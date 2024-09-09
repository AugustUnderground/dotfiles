local M = {}
local vim = vim

M.osx_plugins = { { "wojciech-kulik/xcodebuild.nvim"
                  , dependencies = { "stevearc/oil.nvim"
                                   , "nvim-treesitter/nvim-treesitter"
                                   , }
                  , config = function()
                       require("xcodebuild").setup({ })
                     end }
                , { "mfussenegger/nvim-dap"
                  , dependencies = { "wojciech-kulik/xcodebuild.nvim"
                                   , "nvim-neotest/nvim-nio" }
                  , config = function()
                        local xcodebuild = require("xcodebuild.integrations.dap")
                        local codelldbPath = os.getenv("HOME") .. "/opt/codelldb/extension/adapter/codelldb"
                        xcodebuild.setup(codelldbPath)
                        vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
                        vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
                        vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
                        vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
                        vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
                        vim.keymap.set("n", "<leader>B", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
                        vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })
                      end }
                , { "rcarriga/nvim-dap-ui"
                  , dependencies = { "mfussenegger/nvim-dap" }
                  , lazy = true
                  , config = function()
                        require("dapui").setup({ controls = { element       = "repl"
                                                            , enabled       = true }
                                               , floating = { border        = "single"
                                                            , mappings      = { close = { "q", "<Esc>" } } }
                                               , icons    = { collapsed     = ""
                                                            , expanded      = ""
                                                            , current_frame = "" }
                                               , layouts  = { { elements    = { { id = "stacks", size = 0.25 }
                                                                              , { id = "scopes", size = 0.25 }
                                                                              , { id = "breakpoints", size = 0.25 }
                                                                              , { id = "watches", size = 0.25 } }
                                                              , position    = "left"
                                                              , size        = 60 }
                                                            , { elements    = { { id = "repl", size = 0.35 }
                                                                              , { id = "console", size = 0.65 } }
                                                              , position    = "bottom"
                                                              , size        = 10 } } })
                        local dap, dapui = require("dap"), require("dapui")
                        dap.listeners.after.event_initialized["dapui_config"] = function()
                            dapui.open()
                          end
                        dap.listeners.before.event_terminated["dapui_config"] = function()
                            dapui.close()
                          end
                        dap.listeners.before.event_exited["dapui_config"] = function()
                            dapui.close()
                          end
                      end } }

function M.setup(plugins)
  for _,v in ipairs(M.osx_plugins) do
    table.insert(plugins,v)
  end
  return plugins
end

return M
