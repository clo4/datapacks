# We don't know who scheduled this function, but because there will only be one
# of these functions scheduled at a time, this is fine because only players
# that tried to sprint will be affected and they will be blinded for a minimum
# of 2 ticks.
effect clear @a[tag=no_sprint.blind] blindness
tag @a[tag=no_sprint.blind] remove no_sprint.blind
