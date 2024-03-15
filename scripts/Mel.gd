extends CollisionShape2D
var interact = 0

onready var dialogue = get_parent().get_parent().dialogue

onready var growth = preload("res://items/growth.tres")
onready var ash = preload("res://items/ash.tres")
onready var lily = preload("res://items/Lily.tres")

onready var mana = preload("res://items/mana.tres")
onready var stone = preload("res://items/stone.tres")
onready var embers = preload("res://items/amber.tres")

onready var vial = preload("res://items/vial.tres")
onready var water = preload("res://items/distilled.tres")
onready var essence = preload("res://items/essence.tres")

onready var sugar = preload("res://items/sugar.tres")
onready var milk = preload("res://items/milk.tres")
onready var cookie = preload("res://items/cookie.tres")

onready var candy = preload("res://items/candy.tres")
onready var key = preload("res://items/key.tres")
onready var distilled = preload("res://items/distilled.tres")

func _physics_process(_delta):
	if Input.is_action_pressed("ui_accept") and interact and !get_parent().get_parent().dialogue:
		if !get_parent().get_parent().get_node("Cat").inv_open:
			get_parent().get_parent().get_node("Cat/Inv_UI").open()
			
	if Input.is_action_pressed("ui_end") and interact and !get_parent().get_parent().dialogue:
		if get_parent().get_parent().get_node("Cat").inv_open:
			get_parent().get_parent().get_node("Cat/Inv_UI").close() 
	
func give_item(item: InvItem):	
	get_parent().get_parent().dialogue = 1
	
	if item == candy:
		var dialog = Dialogic.start('Items/Candy')
		dialog.connect("dialogic_signal", self, "dialog_listener")
		add_child(dialog)
		#remove
		get_parent().get_parent().get_node("Cat").remove_item(candy)
		
	elif item == key:
		var dialog = Dialogic.start('Items/Key')
		dialog.connect("dialogic_signal", self, "dialog_listener")
		add_child(dialog)
		
	elif item == distilled:
		var count = get_parent().get_parent().get_node("Cat").count_item(distilled)
		if count == 1:
			var dialog = Dialogic.start('Items/Distilled')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
		else :
			var dialog = Dialogic.start('Items/TakeDistilled')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
			get_parent().get_parent().get_node("Cat").remove_item(distilled)
				
	elif item == sugar:
		var count = get_parent().get_parent().get_node("Cat").count_item(sugar)
		if count == 1:
			var dialog = Dialogic.start('Items/Sugar')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
		else :
			var dialog = Dialogic.start('Items/TakeSugar')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
			get_parent().get_parent().get_node("Cat").remove_item(sugar)
	
	elif item == milk:
		var dialog = Dialogic.start('Items/Milk')
		dialog.connect("dialogic_signal", self, "dialog_listener")
		add_child(dialog)
	
	elif item == cookie:
		var count = get_parent().get_parent().get_node("Cat").count_item(cookie)
		if count == 1:
			var dialog = Dialogic.start('Items/Cookie')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
		else :
			var dialog = Dialogic.start('TakeCookie')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
			get_parent().get_parent().get_node("Cat").remove_item(cookie)
	
	elif item == vial:
		var count = get_parent().get_parent().get_node("Cat").count_item(vial)
		if count == 1:
			var dialog = Dialogic.start('Items/Vial')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
		else :
			var dialog = Dialogic.start('Items/TakeVial')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
			get_parent().get_parent().get_node("Cat").remove_item(vial)
			
	elif item == water:
		var count = get_parent().get_parent().get_node("Cat").count_item(water)
		if count == 1:
			var dialog = Dialogic.start('Items/Water')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
		else :
			var dialog = Dialogic.start('Items/TakeWater')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
			get_parent().get_parent().get_node("Cat").remove_item(water)
	
	elif item == essence:
		var dialog = Dialogic.start('Items/Essence')
		dialog.connect("dialogic_signal", self, "dialog_listener")
		add_child(dialog)
		
	elif item == mana:
		var dialog = Dialogic.start('Items/Mana')
		dialog.connect("dialogic_signal", self, "dialog_listener")
		add_child(dialog)
		#Game end
		
		
	elif item == stone:
		var dialog = Dialogic.start('Items/Stone')
		dialog.connect("dialogic_signal", self, "dialog_listener")
		add_child(dialog)
	
	elif item == embers:
		var dialog = Dialogic.start('Items/Embers')
		dialog.connect("dialogic_signal", self, "dialog_listener")
		add_child(dialog)
	
	elif item == growth:
		var dialog = Dialogic.start('Items/Growth')
		dialog.connect("dialogic_signal", self, "dialog_listener")
		add_child(dialog)
	
	elif item == lily:
		var dialog = Dialogic.start('Items/Lily')
		dialog.connect("dialogic_signal", self, "dialog_listener")
		add_child(dialog)
		
	elif item == ash:
		var count = get_parent().get_parent().get_node("Cat").count_item(ash)
		if count == 1:
			var dialog = Dialogic.start('Items/Ash')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
		else :
			var dialog = Dialogic.start('Items/TakeAsh')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
			get_parent().get_parent().get_node("Cat").remove_item(ash)
	
				
func dialog_listener(string):
	match string:
		"end":
			print("dialog end")
			get_parent().get_parent().dialogue = 0
			get_parent().get_parent().get_node("Cat/Inv_UI").close() 
		"endgame":
			get_tree().change_scene("res://scenes/End.tscn")

func _on_Mel_body_entered(_body):
	$Label.visible = true	
	interact = 1
	get_parent().get_parent().get_node("Cat/Inv_UI").is_give = 1

func _on_Mel_body_exited(_body):
	$Label.visible = false
	interact = 0
	get_parent().get_parent().get_node("Cat/Inv_UI").is_give = 0
