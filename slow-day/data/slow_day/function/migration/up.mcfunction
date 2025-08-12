scoreboard objectives add slow_day.migration dummy

execute unless score #migration slow_day.migration matches 1.. run function slow_day:migration/1_up
