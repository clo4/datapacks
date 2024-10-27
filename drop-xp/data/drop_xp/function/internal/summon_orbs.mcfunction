# For some reason, Mojang chose to drop 7 points per level that you lost when you died.
# That's... not a lot. Maybe a TODO, make this configurable, so you can recover more?
scoreboard players operation @s drop_xp.xp_orb_values = @s drop_xp.dropped_xp
scoreboard players operation @s drop_xp.xp_orb_values *= .7 drop_xp.const

# The game splits the total number of points that you lost into various sizes, greedily putting as
# much as possible into the largest sizes it can. For each size of orb here (replicating the sizes
# listed here: https://minecraft.wiki/w/Experience#Orb_sizes), the orb is spawned with a precalculated
# random motion that is supposed to look close enough to vanilla that you won't ever notice it's not
# *actually* random.
execute if score @s drop_xp.xp_orb_values matches 307.. run function drop_xp:internal/summon_orbs/307/a
execute if score @s drop_xp.xp_orb_values matches 149.. run function drop_xp:internal/summon_orbs/149/a
execute if score @s drop_xp.xp_orb_values matches 73.. run function drop_xp:internal/summon_orbs/73/a
execute if score @s drop_xp.xp_orb_values matches 37.. run function drop_xp:internal/summon_orbs/37/a
execute if score @s drop_xp.xp_orb_values matches 17.. run function drop_xp:internal/summon_orbs/17/a
execute if score @s drop_xp.xp_orb_values matches 7.. run function drop_xp:internal/summon_orbs/7/a
execute if score @s drop_xp.xp_orb_values matches 3.. run function drop_xp:internal/summon_orbs/3/a
execute if score @s drop_xp.xp_orb_values matches 1.. run function drop_xp:internal/summon_orbs/1/a
