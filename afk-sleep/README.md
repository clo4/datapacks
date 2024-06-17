# AFK Sleep

Minecraft versions over 1.21 use the `function` directories, and versions below
will use the `functions` directories. This datapack uses macros for a core part
of the functionality, but because macros were introduced in 1.20.2, to support
older versions a slower method of setting the `playersSleepingPercentage`
gamerule is used (checking every single number between 1 and 100). This logic is
applied in a patch after the `functions` and `advancments` directories are
duplicated for pre-1.21 versions.
