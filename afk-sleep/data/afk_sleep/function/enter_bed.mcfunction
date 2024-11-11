# This is the entrypoint for when a player "sleeps" (uses) a bed. It will trigger immediately upon
# entering the bed, *not* when successfully sleeping.

tellraw @a[tag=afk_sleep.log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"Player entered bed"}]

advancement revoke @s only afk_sleep:enter_bed

function afk_sleep:internal/while_sleeping/is_sleeping
