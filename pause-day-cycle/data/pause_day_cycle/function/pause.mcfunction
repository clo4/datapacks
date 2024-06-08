scoreboard players set #is_paused pause_day_cycle.dummy 1

# Storing the state of these gamerules means if someone manually disables them then the
# datapack won't override that.
execute store result score #do_daylight_cycle pause_day_cycle.dummy run gamerule doDaylightCycle
execute store result score #do_weather_cycle pause_day_cycle.dummy run gamerule doWeatherCycle
gamerule doDaylightCycle false
gamerule doWeatherCycle false

function #pause_day_cycle:pause
