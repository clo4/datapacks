schedule function afk_kick:loop 60s

execute if score .threshold afk_kick.settings < .threshold afk.settings run tellraw @a [{"text":"WARNING: The threshold for kicking AFK players is less than the threshold to set a player as AFK. To fix this, click this message and run the command, or set your own value for the threshold setting.","clickEvent": {"action": "suggest_command","value": "/scoreboard players operation .threshold afk_kick.settings = .threshold afk.settings"}}]

execute as @a[gamemode=!spectator,tag=!afk_kick.ignore,tag=afk] if score @s afk.ticks >= .threshold afk_kick.settings unless score @s afk.left_game matches 1.. run function afk_kick:kick
