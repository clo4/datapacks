scoreboard players set .has_loaded_once drop_xp.config 1

# Only enabling this on first run means if an operator changes this gamerule afterwards
# they will not be confused by their choice not being respected on server restart
gamerule keepInventory true

function drop_xp:set_percent_by_difficulty