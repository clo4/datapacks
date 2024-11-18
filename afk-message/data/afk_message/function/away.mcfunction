# Resetting the current player on the leave_game scoreboard guarantees that if they leave
# while AFK then they will have a score of exactly 1, since this function *must* be called
# before `back.mcfunction`.
scoreboard players reset @s afk_message.leave_game

execute if entity @s[gamemode=!spectator] run tellraw @a [{ "text": "[AFK] ", "color": "gray", "hoverEvent": { "action": "show_text", "contents": "Player hasn't moved their mouse for 3 minutes" }}, { "selector": "@s", "color": "white" }, { "text": " is away", "color": "white" }]
