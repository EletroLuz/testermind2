local plugin_label = "REJI_AUTO_CONSUMABLES"
local menu = {}
local options = require("data.consumable_options")

menu.elements = {
  main_tree = tree_node:new(0),
  main_toggle = checkbox:new(false, get_hash(plugin_label .. "_main_toggle")),
  
  profane_mindcage_slider = slider_int:new(1, 3, 1, get_hash(plugin_label .. "_profane_mindcage_slider")),
  profane_mindcage_toggle = checkbox:new(false, get_hash(plugin_label .. "_profane_mindcage_toggle"))
}

function menu.render()
  if not menu.elements.main_tree:push("Auto Consumables (Reji)") then
    return
  end

  menu.elements.main_toggle:render("Enable", "Toggles Auto Consumables on/off")
  if not menu.elements.main_toggle:get() then
    menu.elements.main_tree:pop()
    return
  end

  -- Renderiza o slider antes do checkbox
  menu.elements.profane_mindcage_slider:render("Profane Mindcage Count", "Select how many Profane Mindcages to use (1-3)")
  menu.elements.profane_mindcage_toggle:render("Use Profane Mindcage", "Toggles Profane Mindcage usage on/off")

  menu.elements.main_tree:pop()
end

return menu