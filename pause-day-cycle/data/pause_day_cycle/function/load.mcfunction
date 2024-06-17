scoreboard objectives add pause_day_cycle.dummy dummy

execute unless score #has_loaded_once pause_day_cycle.dummy matches 1 run function afk_sleep:first_load

# This will schedule itself
function pause_day_cycle:loop
