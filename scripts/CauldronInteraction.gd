extends CollisionShape2D

var interact = 0
var growth_made= 0

onready var dialogue = get_parent().get_parent().dialogue

onready var distilled = preload("res://items/distilled.tres")
onready var lily= preload("res://items/Lily.tres")
onready var stone = preload("res://items/stone.tres")
onready var mana = preload("res://items/mana.tres")

onready var vial = preload("res://items/vial.tres")
onready var sugar = preload("res://items/sugar.tres")
onready var milk = preload("res://items/milk.tres")
onready var essence = preload("res://items/essence.tres")
onready var growth = preload("res://items/growth.tres")

func _physics_process(_delta):
	if Input.is_action_pressed("ui_accept") and interact and !get_parent().get_parent().dialogue:
		get_parent().get_parent().dialogue = 1
		# Add Cookie
		if get_parent().get_parent().read_potion:
			if !growth_made:
				var vial_count = get_parent().get_parent().get_node("Cat").count_item(vial)
				var sugar_count = get_parent().get_parent().get_node("Cat").count_item(sugar)
				var milk_count = get_parent().get_parent().get_node("Cat").count_item(milk)
				var essence_count = get_parent().get_parent().get_node("Cat").count_item(essence)
				
				if get_parent().get_parent().check_flower and vial_count >= 1 and sugar_count >= 1 and milk_count >= 1 and essence_count >=1:
					#remove
					get_parent().get_parent().get_node("Cat").remove_item(vial)
					get_parent().get_parent().get_node("Cat").remove_item(sugar)
					get_parent().get_parent().get_node("Cat").remove_item(milk)
					get_parent().get_parent().get_node("Cat").remove_item(essence)
					#get 
					get_parent().get_parent().get_node("Cat").get_item(growth)
					growth_made= 1
					
					var dialog = Dialogic.start('Cauldron/GetGrowth')
					dialog.connect("dialogic_signal", self, "dialog_listener")
					add_child(dialog)
				else:
					var dialog = Dialogic.start('Cauldron/CanMakeNone')
					dialog.connect("dialogic_signal", self, "dialog_listener")
					add_child(dialog)
			else:
				var distilled_count = get_parent().get_parent().get_node("Cat").count_item(distilled)
				var stone_count = get_parent().get_parent().get_node("Cat").count_item(stone)
				var lily_count = get_parent().get_parent().get_node("Cat").count_item(lily)
				
				
				if distilled_count >= 1 and stone_count >= 1 and lily_count >= 1 :
					#remove
					get_parent().get_parent().get_node("Cat").remove_item(distilled)
					get_parent().get_parent().get_node("Cat").remove_item(stone)
					get_parent().get_parent().get_node("Cat").remove_item(lily)
					#get 
					get_parent().get_parent().get_node("Cat").get_item(mana)
					
					var dialog = Dialogic.start('Cauldron/GetMana')
					dialog.connect("dialogic_signal", self, "dialog_listener")
					add_child(dialog)
				else:
					var dialog = Dialogic.start('Cauldron/CanMakeNone')
					dialog.connect("dialogic_signal", self, "dialog_listener")
					add_child(dialog)	
		else:
			var dialog = Dialogic.start('Cauldron/CanMakeNone')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
				
func dialog_listener(string):
	match string:
		"end":
			print("dialog end")
			get_parent().get_parent().dialogue = 0
	

func _on_Cauldron_body_entered(_body):
	$Label.visible = true
	interact = 1


func _on_Cauldron_body_exited(_body):
	$Label.visible = false
	interact = 0
