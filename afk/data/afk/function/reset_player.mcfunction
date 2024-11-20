# Current rotation is different from previous rotation. If tagged as AFK, that means
# the player has returned.
execute if entity @s[tag=afk] run function afk:tag/back
scoreboard players set @s afk.ticks 0
