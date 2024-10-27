summon minecraft:experience_orb ~ ~ ~ {Value:7,Motion:[-0.146d,0.186d,-0.069d]}
scoreboard players operation @s drop_xp.xp_orb_values -= .7 drop_xp.const
execute if score @s drop_xp.xp_orb_values matches 7.. run function drop_xp:internal/summon_orbs/7/a
