scoreboard players set @s afk 0
execute if score @s afk.ticks_inactive < .ticks_inactive afk.settings run scoreboard players operation @s afk.ticks_inactive = .ticks_inactive afk.settings

# This will store the player's current position so when it's checked again during `loop`
# it will be the same value, so the player will immediately go AFK.
scoreboard players enable @s afk
