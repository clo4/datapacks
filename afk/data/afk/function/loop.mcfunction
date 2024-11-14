schedule function afk:loop 5s replace

# If any players that are able to manually trigger being AFK have done so, they should have
# their afk.seconds_inactive set to the threshold value so they register as AFK during the check.
execute as @a[scores={afk=1..}] run function afk:trigger

execute as @a run function afk:update_position

# Different commands have to be run based on whether or not the player has moved their head.
# This is a temporary value used for that and is reset afterwards.
execute as @a if score @s afk.rot_current = @s afk.rot_previous run scoreboard players set @s afk.is_in_same_pos 1

# increment if the player hasn't moved, or set to 0 if they have
execute as @a[scores={afk.is_in_same_pos=1}] run scoreboard players add @s afk.seconds_inactive 5
execute as @a[scores={afk.is_in_same_pos=0}] run scoreboard players set @s afk.seconds_inactive 0

# reset for the next loop so no players already have their score set to 1
scoreboard players set @a afk.is_in_same_pos 0

# If a player has not been tagged as AFK but they haven't moved for more than the configured
# number of seconds to become AFK, they should be tagged. Likewise, if they are tagged as AFK
# but have moved since being tagged, they should be un-tagged.
execute as @a[tag=!afk] if score @s afk.seconds_inactive >= .seconds_inactive afk.settings at @s run function afk:tag/away
execute as @a[tag=afk] if score @s afk.seconds_inactive < .seconds_inactive afk.settings at @s run function afk:tag/back
