# Same defaults as Terraria - setting the percentage that should be dropped.
# peaceful and easy = 50%, medium = 75%, hard = 100%
execute store result score .difficulty drop_xp.tmp run difficulty
execute if score .difficulty drop_xp.tmp matches ..1 run scoreboard players set .drop_percentage drop_xp.config 50
execute if score .difficulty drop_xp.tmp matches 2 run scoreboard players set .drop_percentage drop_xp.config 75
execute if score .difficulty drop_xp.tmp matches 3.. run scoreboard players set .drop_percentage drop_xp.config 100
scoreboard players reset .difficulty drop_xp.tmp
