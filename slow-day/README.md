# Slow Day

Slow Day slows down the day cycle by extending the day at particular points, rather
than simply making the sun move slower. This is similar to the approach taken in
Mario Kart World, where the day cycle takes a specific number of minutes but will
pause at particularly scenic moments.

This is not ported to older versions due to a visual glitch that was fixed at
some point in the 1.21 cycle, where the sun/moon would continue moving briefly
after the doDaylightCycle gamerule was changed. For vanilla players, this is a
minor glitch, but for players using shaders, it was extremely noticeable because
the shadows would change instantly.

This is designed to be extensible. If you don't like the default durations, you
can just change them:

    /scoreboard players set .midday_ticks slow_day.data 3600

If you don't like the times that the day pauses, you can replace this too. It's a
little more complicated, because you need to create a data pack, but it's a *very*
simple data pack.

First, create `data/slow_day/tags/function/check.json` with the following contents:

```json
{
    "values": [
        "slow_day_overrides:check"
    ],
    "replace": true
}
```

Now, create `data/slow_day_overrides/function/check.mcfunction`, with an adaptation
of the following contents:

```mcfunction
execute if score .time slow_day.data matches 0..99 run scoreboard players set .delay slow_day.data 2400
execute if score .time slow_day.data matches 6000..6099 run scoreboard players set .delay slow_day.data 2400
execute if score .time slow_day.data matches 12000..12099 run scoreboard players set .delay slow_day.data 2400
```

You can have as many lines as you want here, or as few as you want. You check if
the time is in a range of 100 values using `matches`, and set the `.delay` to a
number of ticks to wait before resuming the day cycle - a multiple of 100, as
this value will be decremented 100-at-a-time.
