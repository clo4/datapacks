execute if score .time slow_day.data matches 0..99 run scoreboard players operation .delay slow_day.data = .sunrise_ticks slow_day.data
execute if score .time slow_day.data matches 6000..6099 run scoreboard players operation .delay slow_day.data = .midday_ticks slow_day.data
execute if score .time slow_day.data matches 12000..12099 run scoreboard players operation .delay slow_day.data = .sunset_ticks slow_day.data
