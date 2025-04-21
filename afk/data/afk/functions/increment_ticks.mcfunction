# Current rotation is the same as the previous rotation, so if after incrementing the
# ticks the player has been inactive for, if they've been away for longer than the
# threshold and don't have the AFK tag yet, tag them.
# If you update this, remember to update afk:loop!
scoreboard players add @s afk.ticks 30
execute if entity @s[tag=!afk] if score @s afk.ticks >= .threshold afk.settings at @s run function afk:tag/away
