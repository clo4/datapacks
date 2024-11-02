scoreboard players add .enable_drop_xp no_free_deaths.settings 1
execute if score .enable_drop_xp no_free_deaths.settings matches 1 run tellraw @a {"text": "Players will now drop XP on death"}

execute if score .enable_drop_xp no_free_deaths.settings matches 2 run scoreboard players set .enable_drop_xp no_free_deaths.settings 0
execute if score .enable_drop_xp no_free_deaths.settings matches 0 run tellraw @a {"text": "Players will no longer drop XP on death"}
