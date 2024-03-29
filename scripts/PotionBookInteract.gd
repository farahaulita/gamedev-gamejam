extends CollisionShape2D

var interact = 0

onready var dialogue = get_parent().get_parent().dialogue


func _physics_process(_delta):
	if Input.is_action_pressed("ui_accept") and interact and !get_parent().get_parent().dialogue:
		get_parent().get_parent().dialogue = 1
		# Add Cookie	
		var dialog = Dialogic.start('PotionBook')
		dialog.connect("dialogic_signal", self, "dialog_listener")
		add_child(dialog)
		if !get_parent().get_parent().read_potion:
			get_parent().get_parent().read_potion = 1

		
func dialog_listener(string):
	match string:
		"end":
			print("dialog end")
			get_parent().get_parent().dialogue = 0
	

func _on_PotionBook_body_entered(_body):
	$Label.visible = true	
	interact = 1


func _on_PotionBook_body_exited(_body):
	$Label.visible = false	
	interact = 0
