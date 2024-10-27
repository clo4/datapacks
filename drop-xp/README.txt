Drop XP with keepInventory
==========================

This data pack makes players drop XP on death when `keepInventory` is enabled.

It was designed to give consequences to death to discourage players from using death
as a teleportation and food restoration mechanic, while also removing the tedium
of walking back to the place you died.

---

THE KEEPINVENTORY GAMERULE

The first time you add the data pack to a world, 'keepInventory' will be enabled
if it is not already. If you then choose to disable keepInventory, this data pack
will not re-enable it at any point.

---

HOW MUCH YOU DROP

When you add the data pack to the world, it sets the amount of XP dropped as a
percentage by the difficulty of the world. The same values as Terraria are used
as a default.
- Peaceful and Easy: 50%
- Normal: 75%
- Hard: 100%

If you change the difficulty and want to use the default value for that difficulty,
run the following command:

    /function drop_xp:set_percent_by_difficulty

You can manually set the percentage. The command below, for example, sets the
amount that you will drop on death to 90%.

    /scoreboard players set .drop_percentage drop_xp.config 90

---

LOSING YOUR XP

When a player dies and loses their XP, they will leave XP orbs on the ground, much
like they would have if keepInventory was not enabled. The amount left is the same
as how the game calculates it, which is 7 points per level lost.

If you have the .drop_percentage set to 50 (i.e. lose 50% on death), and you died
at level 30:
- You will lose 15 levels
- 105 points worth of XP orbs will be left on the ground where you died
- The orbs will despawn after 5 minutes, as they would normally.

---

EXCLUDE PLAYERS FROM DROPPING XP

This data pack also allows you to exclude players from losing their XP. Tag them
as 'drop_xp.ignored', for example:

    /tag SomeUsernameHere add drop_xp.ignore

It should go without saying, but players not in survival or adventure mode will not
lose their XP upon death.
