extends Control

onready var is_open = 0
var is_potion = false
var is_give = 0
onready var inv = get_parent().inv
onready var slots = $NinePatchRect/InvCont.get_children()
onready var item_desc =$NinePatchRect/DescCont/Desc/Label
onready var item_name =$NinePatchRect/DescCont/ItemName/Label
var select = 0

func _ready():
	close()
	
func update_slots():
	for i in range(12):
		slots[i].update_item(inv[i])

func _process(_delta):
	if Input.is_action_just_pressed("ui_down") :
		if is_open:
			close()
		else:
			if !get_parent().get_parent().dialogue:
				open()

	if Input.is_action_just_pressed("ui_left") and is_open:
		if select > 0:
			slots[select].deselect()
			select = select-1
			slots[select].select()
			if inv[select] != null:
				item_name.text = inv[select].name
				item_desc.text = inv[select].description
			else:
				item_name.text = ""
				item_desc.text = ""
			
	if Input.is_action_just_pressed("ui_right") and is_open:
		if select < 11:
			slots[select].deselect()
			select = select+1
			slots[select].select()
			if inv[select] != null:
				item_name.text = inv[select].name
				item_desc.text = inv[select].description
			else:
				item_name.text = ""
				item_desc.text = ""
				
	if Input.is_action_just_pressed("dialogic_default_action") and is_open and is_give and slots[select]!= null:
		get_parent().get_parent().dialogue = 1
		close()
		get_parent().get_parent().get_node("Mel/Mel").give_item(inv[select])
		
			
func close():
	visible = false
	is_open = false
	get_parent().inv_open =0
	
func open():
	get_parent().inv_open = 1
	update_slots()
	visible = true
	is_open = true
	slots[select].deselect()
	select = 0
	slots[0].select()
	if inv[select] != null:
				item_name.text = inv[select].name
				item_desc.text = inv[select].description
	else:
		item_name.text = ""
		item_desc.text = ""
	

	
