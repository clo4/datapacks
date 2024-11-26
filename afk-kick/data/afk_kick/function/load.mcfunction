scoreboard objectives add afk_kick.settings dummy

# The default value is 20 minutes (24000t), which is an entire in-game day of inactivity.
execute unless score .threshold afk_kick.settings matches 20.. run scoreboard players set @s afk_kick.settings 24000
