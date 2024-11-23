# Resetting the current player on the leave_game scoreboard guarantees that if they leave
# while AFK then they will have a score of exactly 1, since this function *must* be called
# before `back.mcfunction`.
scoreboard players reset @s afk_message.leave_game

execute if entity @s[gamemode=!spectator] run function afk_message:message_style/select_away
