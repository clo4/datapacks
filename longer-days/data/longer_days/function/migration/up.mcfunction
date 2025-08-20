scoreboard objectives add longer_days.migration dummy

execute unless score #migration longer_days.migration matches 1.. run function longer_days:migration/1_up
