summon minecraft:experience_orb ~ ~ ~ {Value:73,Motion:[-0.084d,0.145d,-0.090d]}
scoreboard players operation @s no_free_deaths.drop_xp.xp_orb_values -= .73 no_free_deaths.drop_xp.const
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 73.. run function no_free_deaths:mechanic/drop_xp/internal/summon_orb/73/a
