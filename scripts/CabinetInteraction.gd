extends CollisionShape2D
var count = 0
var interact = 0
onready var dialogue = get_parent().get_parent().dialogue
onready var key = preload("res://items/key.tres")

func _physics_process(_delta):
	if Input.is_action_pressed("ui_accept") and interact and !get_parent().get_parent().dialogue:
		get_parent().get_parent().dialogue = 1
		if count == 0:
			var dialog = Dialogic.start('Cabinet1')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
			count = count + 1
		
		elif count == 1:
			var dialog = Dialogic.start('Cabinet2')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
			count = count + 1
		
		elif count == 2:
			var add = get_parent().get_parent().get_node("Cat").get_item(key)
			if add:
				var dialog = Dialogic.start('Cabinet3')
				dialog.connect("dialogic_signal", self, "dialog_listener")
				add_child(dialog)
				count = count + 1
				
			else:
				# Change to unique later
				var dialog = Dialogic.start('InvFull')
				dialog.connect("dialogic_signal", self, "dialog_listener")
				add_child(dialog)
		
		else:
			var dialog = Dialogic.start('Cabinet4')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
		


func _on_Cabinet_body_entered(_body):
	$Label.visible = true	
	interact = 1

func _on_Cabinet_body_exited(_body):
	$Label.visible = false	
	interact = 0

func dialog_listener(string):
	match string:
		"end":
			print("dialog end")
			get_parent().get_parent().dialogue = 0

