extends CollisionShape2D
var interact = 0

onready var dialogue = get_parent().get_parent().dialogue
onready var sugar = preload("res://items/sugar.tres")

func _physics_process(_delta):
	if Input.is_action_pressed("ui_accept") and interact and !get_parent().get_parent().dialogue:
		get_parent().get_parent().dialogue = 1
		# Add Cookie
		if get_parent().get_parent().check_flower and get_parent().get_parent().read_potion:
			var add = get_parent().get_parent().get_node("Cat").get_item(sugar)
			if add:
				var dialog = Dialogic.start('GetSugar')
				dialog.connect("dialogic_signal", self, "dialog_listener")
				add_child(dialog)
			else:
				var dialog = Dialogic.start('InvFull')
				dialog.connect("dialogic_signal", self, "dialog_listener")
				add_child(dialog)
		else:
			var dialog = Dialogic.start('CheckSugar')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
			
		
func dialog_listener(string):
	match string:
		"end":
			print("dialog end")
			get_parent().get_parent().dialogue = 0
	
func _on_Sugar_body_entered(_body):
	$Label.visible = true	
	interact = 1


func _on_Sugar_body_exited(_body):
	$Label.visible = false
	interact = 0
