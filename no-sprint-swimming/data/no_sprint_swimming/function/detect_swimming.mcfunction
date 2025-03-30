# A player that is not tagged as swimming but is currently swimming should be
# tagged as swimming. This is the most likely case, since most players aren't
# swimming all the time.
execute if entity @s[tag=!no_sprint_swimming.is_swimming] run return run execute if predicate no_sprint_swimming:is_swimming run function no_sprint_swimming:player_started_swimming

# Below this point, because of the early return, players are guaranteed to be tagged.

# If the player is holding sprint while tagged, they should be blinded repeatedly
# to make sure it doesn't wear off.
execute if predicate no_sprint_swimming:is_holding_sprint run return run function no_sprint_swimming:player_holding_sprint

# Below this point, the player is not holding the sprint key.

# Tagged, but not currently swimming, and not holding sprint - blindness can be
# removed.
execute unless predicate no_sprint_swimming:is_swimming run function no_sprint_swimming:player_stopped_swimming
