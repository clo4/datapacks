scoreboard objectives add respawn_sickness.settings dummy
scoreboard objectives add respawn_sickness.death_count deathCount

execute unless score .has_loaded_once respawn_sickness.settings matches 1 run function respawn_sickness:internal/first_load

function respawn_sickness:internal/loop
