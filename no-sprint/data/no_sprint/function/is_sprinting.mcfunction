effect give @s blindness infinite 0 true
tag @s add no_sprint.blind

# 1t is not enough to stop sprinting, has to be 2t.
# It looks like there's a race condition here, and that's true, but it doesn't
# matter because of the 'tick' function checking every tick.
schedule function no_sprint:unblind 2t
