effect clear @s resistance

clear @s minecraft:black_stained_glass_pane[custom_data~{slot_filler: true}]

item modify entity @s armor.head afk_immunity:remove_unbreakable
item modify entity @s armor.chest afk_immunity:remove_unbreakable
item modify entity @s armor.legs afk_immunity:remove_unbreakable
item modify entity @s armor.feet afk_immunity:remove_unbreakable

item modify entity @s armor.head afk_immunity:remove_cob
item modify entity @s armor.chest afk_immunity:remove_cob
item modify entity @s armor.legs afk_immunity:remove_cob
item modify entity @s armor.feet afk_immunity:remove_cob

tag @s remove afk_immunity.has_been_modified
