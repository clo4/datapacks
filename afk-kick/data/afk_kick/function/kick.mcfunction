# Any functions that need to be notified that a player has been kicked for inactivity
# will be executed before the player has been kicked.
function #afk_kick:player_will_be_kicked

# Kicks the player while they still have their afk tag, but resets
# their ticks. When they come back, there is no chance that they'll get kicked.
kick @s AFK for more than 15 minutes
