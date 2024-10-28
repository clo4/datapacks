advancement revoke @s only drop_xp:die

execute store result score .keepInventory_is_enabled drop_xp.tmp run gamerule keepInventory

# Player must be:
# - Not in creative or spectator (i.e. is in survival or adventure)
# - In a world with keepInventory enabled
# - Not excluded from dropping XP
# - Not configured to drop 0% of their XP
execute \
  if score .keepInventory_is_enabled drop_xp.tmp matches 1 \
  if entity @s[gamemode=!creative,gamemode=!spectator,tag=!drop_xp.ignore] \
  unless score .drop_percentage drop_xp.settings matches 0 \
  as @s at @s \
  run \
    function drop_xp:internal/drop_xp

# Version 3819 (1.20.5) introduced the new /clear syntax which is required to do this
# in a way that isn't entirely too complicated. The command has to be in another file because
# it could cause parser errors in 1.20.2, which is supposed to be fully supported.
execute store result score .data_version drop_xp.tmp run data get entity @s DataVersion
execute \
  if score .keepInventory_is_enabled drop_xp.tmp matches 1 \
  if score .clear_curse_of_vanishing drop_xp.settings matches 1 \
  if score .data_version drop_xp.tmp matches 3819.. \
  if entity @s[gamemode=!creative,gamemode=!spectator,tag=!drop_xp.ignore_curse_of_vanishing] \
  as @s at @s \
  run \
    function drop_xp:internal/clear_curse_of_vanishing
