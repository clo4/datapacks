summon minecraft:experience_orb ~ ~ ~ {Value:17,Motion:[-0.0881d,0.1597d,-0.0152d]}
scoreboard players operation @s drop_xp.xp_orb_values -= .17 drop_xp.const
execute if score @s drop_xp.xp_orb_values matches 17.. run function drop_xp:internal/summon_orbs/17/b
