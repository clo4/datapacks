scoreboard players add .enable_respawn_health_penalty no_free_deaths.settings 1
execute if score .enable_respawn_health_penalty no_free_deaths.settings matches 2.. run scoreboard players set .enable_respawn_health_penalty no_free_deaths.settings 0

execute if score .enable_respawn_health_penalty no_free_deaths.settings matches 1 run tellraw @a {"text": "Players will now respawn with a health penalty"}
execute if score .enable_respawn_health_penalty no_free_deaths.settings matches 0 run tellraw @a {"text": "Players will no longer respawn with a health penalty"}
