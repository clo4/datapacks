# The time of day only needs to be updated if we're actually going to check it.
execute store result score .time longer_days.data run time query daytime

execute if score .time longer_days.data matches 0..99 run scoreboard players operation .extended_daytime longer_days.data = .sunrise longer_days.settings
execute if score .time longer_days.data matches 2600..2699 run scoreboard players operation .extended_daytime longer_days.data = .morning longer_days.settings
execute if score .time longer_days.data matches 5950..6049 run scoreboard players operation .extended_daytime longer_days.data = .noon longer_days.settings
execute if score .time longer_days.data matches 9600..9699 run scoreboard players operation .extended_daytime longer_days.data = .afternoon longer_days.settings

# This timing is very specific, because tick 12010 is the first tick that beds can be used in rainy weather.
# Pausing from 12000..12099 would mean there's room for some inconsistency in whether a player can get in a bed
# while it's raining.
execute if score .time longer_days.data matches 11910..12009 run scoreboard players operation .extended_daytime longer_days.data = .sunset longer_days.settings

# By default, these don't extend the time, but it's a good configuration point.
execute if score .time longer_days.data matches 13670..13769 run scoreboard players operation .extended_daytime longer_days.data = .twilight_evening longer_days.settings
execute if score .time longer_days.data matches 17950..18049 run scoreboard players operation .extended_daytime longer_days.data = .midnight longer_days.settings
execute if score .time longer_days.data matches 22000..22099 run scoreboard players operation .extended_daytime longer_days.data = .twilight_morning longer_days.settings
