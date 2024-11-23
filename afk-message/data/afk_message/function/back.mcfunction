execute if entity @s[gamemode=!spectator] unless score @s afk_message.leave_game matches 1.. run function afk_message:message_style/select_back
