# Normally I wouldn't use a scoreboard without a namespace, but since `afk` is the namespace
# and it's very unlikely someone would have a separate `afk` scoreboard if they're using this
# data pack, it's fine to create this table.
scoreboard objectives add afk trigger

scoreboard objectives add afk.settings dummy

# .seconds_inactive is a user-configurable setting that controls how many seconds of inactivity
# it takes for a player to become AFK. Currently, 
execute unless score .seconds_inactive afk.settings matches 1.. run scoreboard players set .seconds_inactive afk.settings 180

scoreboard objectives add afk.seconds_inactive dummy

schedule function afk:loop 1s replace
