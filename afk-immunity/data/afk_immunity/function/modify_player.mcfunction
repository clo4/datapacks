effect give @s resistance infinite 255 true

# While the player is AFK, even with the resistance effect applied, damage
# could still possibly break their armor. This wouldn't be a great experience
# for them! The best thing to do is just make all their armor unbreakable
# while they're AFK and remove that component when they're back.
item modify entity @s armor.head afk_immunity:add_unbreakable
item modify entity @s armor.chest afk_immunity:add_unbreakable
item modify entity @s armor.legs afk_immunity:add_unbreakable
item modify entity @s armor.feet afk_immunity:add_unbreakable

# If the player were to return and open their inventory without moving their
# mouse at all, they could drop their armor on the ground, move their mouse,
# and pick up the now permanently unbreakable gear. I don't think there's a
# *good* workaround for this, but by adding Curse of Binding, they simply can't
# drop it or take it off while AFK.
# It's reasonable that some of their armor may already have COB, so this adds 1
# to the COB level, and the corresponding "back" function subtracts 1. If the
# level hits 0, the game removes the enchantment. Items with pre-existing COB
# will still have it, but items that gained it from this function will not.
#
# We're doing this in a function protected by a separate tag because if an
# admin were to remove the `afk` tag from the player, the `afk_immunity:away`
# function would execute again. This would increase the COB level twice, but
# only subtract 1 when they get back, making the execution non-idempotent.
#
# FIXME: Technically this could still be abused, since a player that has some
# COB armor that they want to remove the enchantment from could wait to become
# AFK, put the item on, then come back. But I think this would be enough of a
# pain in the ass that most people won't bother doing that, if they even think
# of it in the first place.
item modify entity @s armor.head afk_immunity:add_cob
item modify entity @s armor.chest afk_immunity:add_cob
item modify entity @s armor.legs afk_immunity:add_cob
item modify entity @s armor.feet afk_immunity:add_cob

tag @s add afk_immunity.has_been_modified
