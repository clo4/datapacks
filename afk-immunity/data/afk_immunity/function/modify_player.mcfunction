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
item modify entity @s armor.head afk_immunity:add_cob
item modify entity @s armor.chest afk_immunity:add_cob
item modify entity @s armor.legs afk_immunity:add_cob
item modify entity @s armor.feet afk_immunity:add_cob

item modify entity @s armor.head afk_immunity:hide_unbreakable
item modify entity @s armor.chest afk_immunity:hide_unbreakable
item modify entity @s armor.legs afk_immunity:hide_unbreakable
item modify entity @s armor.feet afk_immunity:hide_unbreakable

# There's an edge-case where, because all the armor will have CoB removed when
# the player returns, the player could place an item that they want to remove
# the curse from in an empty slot before returning.
# However, if there are invisible items occupying the empty slots, this can't
# be exploited.
execute unless items entity @s armor.head * run item replace entity @s armor.head with minecraft:black_stained_glass_pane[minecraft:custom_data={slot_filler: true},minecraft:enchantments={binding_curse: 1},minecraft:enchantment_glint_override=false,minecraft:item_name="Unusable Item Slot",tooltip_display={hide_tooltip:true},minecraft:equippable={slot:head},item_model="minecraft:air"]
execute unless items entity @s armor.chest * run item replace entity @s armor.chest with minecraft:black_stained_glass_pane[minecraft:custom_data={slot_filler: true},minecraft:enchantments={binding_curse: 1},minecraft:enchantment_glint_override=false,minecraft:item_name="Unusable Item Slot",tooltip_display={hide_tooltip:true},minecraft:equippable={slot:chest},item_model="minecraft:air"]
execute unless items entity @s armor.legs * run item replace entity @s armor.legs with minecraft:black_stained_glass_pane[minecraft:custom_data={slot_filler: true},minecraft:enchantments={binding_curse: 1},minecraft:enchantment_glint_override=false,minecraft:item_name="Unusable Item Slot",tooltip_display={hide_tooltip:true},minecraft:equippable={slot:legs},item_model="minecraft:air"]
execute unless items entity @s armor.feet * run item replace entity @s armor.feet with minecraft:black_stained_glass_pane[minecraft:custom_data={slot_filler: true},minecraft:enchantments={binding_curse: 1},minecraft:enchantment_glint_override=false,minecraft:item_name="Unusable Item Slot",tooltip_display={hide_tooltip:true},minecraft:equippable={slot:feet},item_model="minecraft:air"]

attribute @s jump_strength modifier add afk_immunity:no_jump -10000 add_value
attribute @s entity_interaction_range modifier add afk_immunity:no_interaction -10000 add_value
attribute @s oxygen_bonus modifier add afk_immunity:no_drowning 10000 add_value

# afk v1.3 does this by default but this makes it compatible with older versions
attribute @s movement_speed modifier add afk_immunity:no_movement -10000 add_value

tag @s add afk_immunity.is_immune
