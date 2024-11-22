# Kicks the player while they still have their afk tag, but resets
# their ticks. When they come back, there is no chance that they'll get kicked.
scoreboard players set @s afk.ticks 0
kick @s AFK for more than 15 minutes
