extends CollisionShape2D

var interact = 0

onready var dialogue = get_parent().get_parent().dialogue
onready var vial= preload("res://items/vial.tres")

func _physics_process(_delta):
	if Input.is_action_pressed("ui_accept") and interact and !get_parent().get_parent().dialogue:
		get_parent().get_parent().dialogue = 1
		# Add Cookie
		var add = get_parent().get_parent().get_node("Cat").get_item(vial)
		if add:
			var dialog = Dialogic.start('GetVial')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
		else:
			var dialog = Dialogic.start('InvFull')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
			
func dialog_listener(string):
	match string:
		"end":
			print("dialog end")
			get_parent().get_parent().dialogue = 0	

func _on_GlassVial_body_entered(_body):
	$Label.visible = true	
	interact = 1

func _on_GlassVial_body_exited(_body):
	$Label.visible = false	
	interact = 0
