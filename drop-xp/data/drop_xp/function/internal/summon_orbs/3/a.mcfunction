summon minecraft:experience_orb ~ ~ ~ {Value:3,Motion:[-0.0615d,0.1079d,-0.0844d]}
scoreboard players operation @s drop_xp.xp_orb_values -= .3 drop_xp.const
execute if score @s drop_xp.xp_orb_values matches 3.. run function drop_xp:internal/summon_orbs/3/b
