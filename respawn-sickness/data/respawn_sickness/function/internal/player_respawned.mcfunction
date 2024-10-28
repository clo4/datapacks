scoreboard players reset @s respawn_sickness.death_count

execute if score .hunger_penalty respawn_sickness.settings matches 1 if entity @s[tag=!respawn_sickness.ignore] run function respawn_sickness:internal/penalty/hunger

# As an implementation detail, we know that the hunger will be applied for 2 seconds (40t), so we
# wait for it to run out before applying damage. Otherwise, the player may regenerate some health.
execute if score .health_penalty respawn_sickness.settings matches 1 if entity @s[tag=!respawn_sickness.ignore] run function respawn_sickness:internal/penalty/health
