# The game splits the total number of points that you lost into various sizes, greedily putting as
# much as possible into the largest sizes it can. For each size of orb here (replicating the sizes
# listed here: https://minecraft.wiki/w/Experience#Orb_sizes), the orb is spawned with a precalculated
# random motion that is supposed to look close enough to vanilla that you won't ever notice it's not
# *actually* random.
execute if score @s nfd_drop_xp.xp_orb_values matches 2477.. run function nfd_drop_xp:internal/summon_orb/2477/a
execute if score @s nfd_drop_xp.xp_orb_values matches 1237.. run function nfd_drop_xp:internal/summon_orb/1237/a
execute if score @s nfd_drop_xp.xp_orb_values matches 617.. run function nfd_drop_xp:internal/summon_orb/617/a
execute if score @s nfd_drop_xp.xp_orb_values matches 307.. run function nfd_drop_xp:internal/summon_orb/307/a
execute if score @s nfd_drop_xp.xp_orb_values matches 149.. run function nfd_drop_xp:internal/summon_orb/149/a
execute if score @s nfd_drop_xp.xp_orb_values matches 73.. run function nfd_drop_xp:internal/summon_orb/73/a
execute if score @s nfd_drop_xp.xp_orb_values matches 37.. run function nfd_drop_xp:internal/summon_orb/37/a
execute if score @s nfd_drop_xp.xp_orb_values matches 17.. run function nfd_drop_xp:internal/summon_orb/17/a
execute if score @s nfd_drop_xp.xp_orb_values matches 7.. run function nfd_drop_xp:internal/summon_orb/7/a
execute if score @s nfd_drop_xp.xp_orb_values matches 3.. run function nfd_drop_xp:internal/summon_orb/3/a
execute if score @s nfd_drop_xp.xp_orb_values matches 1.. run function nfd_drop_xp:internal/summon_orb/1/a
