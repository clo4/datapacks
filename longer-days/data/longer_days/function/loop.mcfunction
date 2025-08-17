schedule function longer_days:loop 100t

# Before we check whether the day should be extended, first we can check whether
# we're in sync with what we expected. At the end of this function, we know that we're
# in sync, so if we're not, a player must have changed something.
execute store result score .do_daylight_cycle longer_days.data run gamerule doDaylightCycle

# if do_daylight_cycle == true and extended_daytime > 0:
#   - The player has enabled the day cycle while it was previously paused.
#     Day cycle should remain enabled. We want to keep checking the time
#     for whether we should pause, but during this cycle, it's possible
#     we could pause for the same time of day (depending on exactly when
#     the day cycle was resumed), so we need to skip checking for this
#     loop.
execute if score .do_daylight_cycle longer_days.data matches 1 if score .extended_daytime longer_days.data matches 1.. run return run scoreboard players set .extended_daytime longer_days.data 0

# if do_daylight_cycle == false and extended_daytime == 0
#   - The player has paused the day cycle while it was previously enabled.
#     We shouldn't resume the day cycle no matter what. While this case
#     is met, we early exit the function.
execute if score .do_daylight_cycle longer_days.data matches 0 if score .extended_daytime longer_days.data matches ..0 run return 1


# Now that we're here, we know we're in sync with the state we expected.
# First thing to do is subtract the number of ticks that have passed from the
# countdown until we resume.
execute if score .extended_daytime longer_days.data matches 1.. run scoreboard players remove .extended_daytime longer_days.data 100

execute if score .do_daylight_cycle longer_days.data matches 1 run function longer_days:check

execute if score .extended_daytime longer_days.data matches 1.. run gamerule doDaylightCycle false
execute if score .extended_daytime longer_days.data matches ..0 run gamerule doDaylightCycle true

# This is only for debugging, to visualize the change to the gamerule.
execute store result score .do_daylight_cycle longer_days.data run gamerule doDaylightCycle
