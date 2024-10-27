scoreboard players reset @s drop_xp.death_count

# As a sanity check, if the configured drop percentage is out of bounds, it will be
# brought back within the range of allowed values.
execute if score .drop_percentage drop_xp.config matches 101.. run scoreboard players set .drop_percentage drop_xp.config 100
execute if score .drop_percentage drop_xp.config matches ..-1 run scoreboard players set .drop_percentage drop_xp.config 0

execute store result score .keepInventory_is_enabled drop_xp.tmp run gamerule keepInventory

# Player must be:
# - Not in creative or spectator (i.e. is in survival or adventure)
# - In a world with keepInventory enabled
# - Not excluded from dropping XP
# - Not configured to drop 0% of their XP
execute \
  if score .keepInventory_is_enabled drop_xp.tmp matches 1 \
  if entity @s[gamemode=!creative,gamemode=!spectator,tag=!drop_xp.ignored] \
  unless score .drop_percentage drop_xp.config matches 0 \
  as @s at @s \
  run \
    function drop_xp:internal/drop_xp
