# This will be used to store the time rounded to the nearest 100.
# 100 is significant because with 20 ticks in a second, and a 5
# second loop, the time will always increment by 100 when we check.
scoreboard objectives add slow_day.data dummy

execute unless score #version slow_day.data matches 1 run function slow_day:init

function slow_day:loop
