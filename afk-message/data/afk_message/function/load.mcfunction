scoreboard objectives add afk_message.settings dummy
execute unless score .style afk_message.settings matches 1.. run scoreboard players set .style afk_message.settings 1
