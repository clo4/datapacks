scoreboard players add .hunger_penalty respawn_sickness.settings 1
execute if score .hunger_penalty respawn_sickness.settings matches 1 run say Hunger penalty is now enabled.

execute if score .hunger_penalty respawn_sickness.settings matches 2 run scoreboard players set .hunger_penalty respawn_sickness.settings 0
execute if score .hunger_penalty respawn_sickness.settings matches 0 run say Hunger penalty is now disabled.
