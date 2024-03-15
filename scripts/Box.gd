extends CollisionShape2D

var interact = 0
var key_get = 0
onready var dialogue = get_parent().get_parent().dialogue
onready var key = preload("res://items/key.tres")
onready var stone = preload("res://items/stone.tres")


func _physics_process(_delta):
	if Input.is_action_pressed("ui_accept") and interact and !get_parent().get_parent().dialogue:
		get_parent().get_parent().dialogue = 1
		# Add Cooki
		if !key_get:
			var remove = get_parent().get_parent().get_node("Cat").remove_item(key)
			if remove:
				var dialog = Dialogic.start('GetStone')
				dialog.connect("dialogic_signal", self, "dialog_listener")
				add_child(dialog)
				key_get = 1
				get_parent().get_parent().get_node("Cat").get_item(stone)
			else:
				var dialog = Dialogic.start('Locked')
				dialog.connect("dialogic_signal", self, "dialog_listener")
				add_child(dialog)
		else :
			var dialog = Dialogic.start('KeyGet')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)

func dialog_listener(string):
	match string:
		"end":
			print("dialog end")
			get_parent().get_parent().dialogue = 0
#

func _on_Box_body_entered(_body):
	$Label.visible = true
	interact = 1


func _on_Box_body_exited(_body):
	$Label.visible = false
	interact = 0
