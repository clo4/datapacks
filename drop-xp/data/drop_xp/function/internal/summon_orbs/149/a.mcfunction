summon minecraft:experience_orb ~ ~ ~ {Value:149,Motion:[0.0447d,0.2192d,-0.0417d]}
scoreboard players operation @s drop_xp.xp_orb_values -= .149 drop_xp.const
execute if score @s drop_xp.xp_orb_values matches 149.. run function drop_xp:internal/summon_orbs/149/b
