# Normally I wouldn't use a scoreboard without a namespace, but since `afk` is the namespace
# and it's very unlikely someone would have a separate `afk` scoreboard if they're using this
# data pack, it's fine to create this table. `/trigger afk` is worth it.
scoreboard objectives add afk trigger

scoreboard objectives add afk.rotation dummy
scoreboard objectives add afk.rotation_prev dummy

scoreboard objectives add afk.settings dummy

# This might eventually be exposed as part of the public API, but it is not for now.
scoreboard objectives add afk.leave_game minecraft.custom:minecraft.leave_game

# .ticks is a user-configurable setting that controls how many seconds of inactivity
# it takes for a player to become AFK. 3600 ticks is 180 seconds - this is a very intentional
# default. It's long enough to yellow without going AFK, but not long enough to brown :^)
execute unless score .ticks afk.settings matches 1.. run scoreboard players set .ticks afk.settings 3600

scoreboard objectives add afk.ticks dummy

function afk:loop
