# This has to use `unless` to include the case where #is_paused has no score yet
execute unless score #is_paused pause_day_cycle.dummy matches 1 run function pause_day_cycle:check_should_pause
execute if score #is_paused pause_day_cycle.dummy matches 1 run function pause_day_cycle:check_should_resume

schedule function pause_day_cycle:loop 5s
