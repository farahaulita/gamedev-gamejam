extends Panel

onready var item_visual = $CenterContainer/Panel/Sprite
var selected = false
onready var item_name = get_parent().get_parent().get_node("DescCont/ItemName/Label")
onready var item_desc = get_parent().get_parent().get_node("DescCont/Desc/Label")

func update_item(item: InvItem):
	if !item:
		item_visual.visible =false
	else:
		item_visual.visible = true
		item_visual.texture = item.texture
		
func select():
	$Active.visible = true
	
		
		
	
func deselect():
	$Active.visible = false
