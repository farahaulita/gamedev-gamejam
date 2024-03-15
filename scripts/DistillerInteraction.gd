extends CollisionShape2D

var interact = 0
var on = 0
onready var dialogue = get_parent().get_parent().dialogue
onready var distilled = preload("res://items/distilled.tres")
onready var water = preload("res://items/water.tres")
onready var embers = preload("res://items/amber.tres")

func _physics_process(_delta):
	if Input.is_action_pressed("ui_accept") and interact and !get_parent().get_parent().dialogue:
		get_parent().get_parent().dialogue = 1
		if on:
			var remove = get_parent().get_parent().get_node("Cat").remove_item(water)
			if remove:
				var dialog = Dialogic.start('Distiller/GetDistilled')
				dialog.connect("dialogic_signal", self, "dialog_listener")
				add_child(dialog)
				get_parent().get_parent().get_node("Cat").get_item(distilled)
			else:
				var dialog = Dialogic.start('Distiller/DistillOn')
				dialog.connect("dialogic_signal", self, "dialog_listener")
				add_child(dialog)
		else:
			var remove = get_parent().get_parent().get_node("Cat").remove_item(embers)
			if remove:
				var dialog = Dialogic.start('Distiller/DistillHeat')
				dialog.connect("dialogic_signal", self, "dialog_listener")
				add_child(dialog)
				on = 1
				# Change Sprite
			else:
				var dialog = Dialogic.start('Distiller/DistillOff')
				dialog.connect("dialogic_signal", self, "dialog_listener")
				add_child(dialog)
		
func dialog_listener(string):
	match string:
		"end":
			print("dialog end")
			get_parent().get_parent().dialogue = 0

func _on_Distiller_body_entered(_body):
	$Label.visible = true	
	interact = 1


func _on_Distiller_body_exited(_body):
	$Label.visible = false
	interact = 0
