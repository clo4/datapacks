#> afk_sleep:loop
# This starts a loop of checking the amount of players online in total, which needs to be kept
# up to date because if a player joins or leaves that will affect the percentage of players
# that need to sleep.

scoreboard players operation #prevTotalPlayers afk_sleep.dummy = .totalPlayers afk_sleep.dummy
execute store result score .totalPlayers afk_sleep.dummy run list

# This execute has the additional condition to check that the number of players online is above
# zero because the formula for calculating the sleeping percentage divides by the player count.
# There's no other way a divide-by-zero could happen with the player count because AFK events
# can't be triggered if there are no players online to trigger them.
execute unless score .totalPlayers afk_sleep.dummy matches 0 unless score #prevTotalPlayers afk_sleep.dummy = .totalPlayers afk_sleep.dummy run function afk_sleep:state_change

schedule function afk_sleep:loop 10s