summon minecraft:experience_orb ~ ~ ~ {Value:3,Motion:[0.096d,0.269d,-0.029d]}
scoreboard players operation @s drop_xp.xp_orb_values -= .3 drop_xp.const
execute if score @s drop_xp.xp_orb_values matches 3.. run function drop_xp:internal/summon_orbs/3/a
