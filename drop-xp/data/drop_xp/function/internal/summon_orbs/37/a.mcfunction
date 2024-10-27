summon minecraft:experience_orb ~ ~ ~ {Value:37,Motion:[-0.0973d,0.2606d,-0.0295d]}
scoreboard players operation @s drop_xp.xp_orb_values -= .37 drop_xp.const
execute if score @s drop_xp.xp_orb_values matches 37.. run function drop_xp:internal/summon_orbs/37/b
