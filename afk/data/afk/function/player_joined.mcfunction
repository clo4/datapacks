# This might eventually be part of the public API, but until it is, I'm going
# to make sure the score is reset before #afk:back is called to make sure it
# can't be used.
scoreboard players reset @s afk.leave_game
function afk:reset_player
