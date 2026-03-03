-- Core configuration
-- looks at ~/.config/nvim/lua/core
require("core.options")
require("core.autocmd")
require("core.mappings")

--------------------------
-- ======= Plugins =======
--------------------------
-- Install and setup plugins
-- looks at ~/.config/nvim/lua/plugins.lua
require("plugins")
