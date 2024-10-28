scoreboard objectives add respawn_hunger.settings dummy
scoreboard objectives add respawn_hunger.death_count deathCount

scoreboard players set .hunger_penalty respawn_hunger.settings 1
scoreboard players set .health_penalty respawn_hunger.settings 1

function respawn_hunger:loop
