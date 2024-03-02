extends Control

var is_open = false
var is_potion = false
var is_give = false
onready var inv = preload("res://playerinv.tres")
onready var slots = $GridContainer.get_children()
var select = 0

func _ready():
	close()
	
func update_slots():
	for i in range(11):
		slots[i].update_item(inv.items[i])

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		if is_open:
			close()
		else:
			open()

	if Input.is_action_just_pressed("ui_left") and is_open:
		if select > 0:
			slots[select].deselect()
			select = select-1
			slots[select].select()
			
	if Input.is_action_just_pressed("ui_right") and is_open:
		if select < 11:
			slots[select].deselect()
			select = select+1
			slots[select].select()

			
			
func close():
	visible = false
	is_open = false
	
func open():
	update_slots()
	visible = true
	is_open = true

func item_dialog(item:InvItem):
	pass
	
