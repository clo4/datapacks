schedule function slow_day:loop 100t

scoreboard players remove .delay slow_day.data 100

execute store result score .time slow_day.data run time query daytime
execute store result score .daycycle slow_day.data run gamerule doDaylightCycle

# If the day cycle is currently enabled, see if we should wait.
execute if score .daycycle slow_day.data matches 1 run function #slow_day:check

execute if score .delay slow_day.data matches ..0 run gamerule doDaylightCycle true
execute if score .delay slow_day.data matches 1.. run gamerule doDaylightCycle false
