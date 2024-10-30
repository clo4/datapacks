advancement revoke @s only drop_xp:die

execute store result score .keepInventory_is_enabled drop_xp.tmp run gamerule keepInventory

# As a sanity check, if the configured drop percentage is out of bounds, it will be
# brought back within the range of allowed values. This is also done because it allows
# us to skip the work if 0% would be dropped, which is unlikely, but a possible case.
execute if score .drop_percentage drop_xp.settings matches 101.. run scoreboard players set .drop_percentage drop_xp.settings 100
execute if score .drop_percentage drop_xp.settings matches ..-1 run scoreboard players set .drop_percentage drop_xp.settings 0

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

execute \
  if score .keepInventory_is_enabled drop_xp.tmp matches 1 \
  if score .clear_curse_of_vanishing drop_xp.settings matches 1 \
  if entity @s[gamemode=!creative,gamemode=!spectator,tag=!drop_xp.ignore_curse_of_vanishing] \
  as @s at @s \
  run \
    function drop_xp:internal/clear_curse_of_vanishing
