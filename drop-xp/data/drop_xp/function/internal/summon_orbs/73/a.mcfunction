summon minecraft:experience_orb ~ ~ ~ {Value:73,Motion:[0.0407d,0.2549d,0.0605d]}
scoreboard players operation @s drop_xp.xp_orb_values -= .73 drop_xp.const
execute if score @s drop_xp.xp_orb_values matches 73.. run function drop_xp:internal/summon_orbs/73/b