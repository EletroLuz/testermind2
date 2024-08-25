local menu = require("menu")
local options = require("data.consumable_options")

local last_profane_mindcage_use = 0
local profane_mindcage_cooldown = 3600 -- 1 hora em segundos

local function check_for_player_buff(buffs, option)
  for _, buff in ipairs(buffs) do
    if buff:name() == option then
      return true
    end
  end
  return false
end

local function use_profane_mindcage(consumable_items)
  local current_time = get_time_since_inject()
  if current_time - last_profane_mindcage_use >= profane_mindcage_cooldown then
    for _, item in ipairs(consumable_items) do
      if item:get_name() == "Helltide_ProfaneMindcage" then
        use_item(item)
        last_profane_mindcage_use = current_time
        break
      end
    end
  end
end

on_update(function()
  local local_player = get_local_player()

  if local_player and menu.elements.main_toggle:get() and menu.elements.profane_mindcage_toggle:get() then
    local player_position = get_player_position()
    local buffs = local_player:get_buffs()
    local consumable_items = local_player:get_consumable_items()

    local closest_target = target_selector.get_target_closer(player_position, 10)

    if closest_target then
      if not check_for_player_buff(buffs, "Helltide_ProfaneMindcage") then
        use_profane_mindcage(consumable_items)
      end
    end
  end
end)

on_render_menu(menu.render)