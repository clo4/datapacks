schedule function slow_day:loop 100t

execute if score .extended_daytime slow_day.data matches 1.. run scoreboard players remove .extended_daytime slow_day.data 100

execute store result score .time slow_day.data run time query daytime
execute store result score .do_daylight_cycle slow_day.data run gamerule doDaylightCycle

# If the day cycle is currently enabled, see if we should wait.
execute if score .do_daylight_cycle slow_day.data matches 1 run function slow_day:check
execute if score .do_daylight_cycle slow_day.data matches 1 if score .extended_daytime slow_day.data matches 1.. run gamerule doDaylightCycle false

# The range -99 to 0 is significant. If it's below that, we should never resume
# the day cycle because it may have been paused manually. In this range, we know that
# we've just come out of an automated pause.
execute if score .do_daylight_cycle slow_day.data matches 0 unless score .extended_daytime slow_day.data matches ..0 run gamerule doDaylightCycle true
