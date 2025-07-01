# Current rotation is different from previous rotation. If tagged as AFK, that means
# the player has returned, so their tag should be removed and any functions should be
# called before the scoreboard value is reset (which allows any functions to use the
# value).
execute if entity @s[tag=afk] run function afk:tag/back
scoreboard players set @s afk.ticks 0
