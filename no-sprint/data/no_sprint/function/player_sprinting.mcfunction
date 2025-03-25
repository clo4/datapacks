effect give @s blindness infinite 0 true
tag @s add no_sprint.blind

# 1t is not enough to stop sprinting, has to be 2t.
schedule function no_sprint:unblind 2t replace
