scoreboard objectives add respawn_sickness.settings dummy
scoreboard objectives add respawn_sickness.death_count deathCount

scoreboard players set .hunger_penalty respawn_sickness.settings 1
scoreboard players set .health_penalty respawn_sickness.settings 1

function respawn_sickness:loop
