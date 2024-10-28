# If the hunger penalty is enabled, the player will regen exactly 1 health point during the effect.
# As a workaround, damaging the player by 11 will result in the final loss of 10 health points.
execute if score .hunger_penalty respawn_sickness.settings matches 1 run damage @s 11 generic_kill
execute if score .hunger_penalty respawn_sickness.settings matches 0 run damage @s 10 generic_kill
