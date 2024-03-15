extends CollisionShape2D

var interact = 0
var get_milk = 0
onready var dialogue = get_parent().get_parent().dialogue
onready var milk = preload("res://items/milk.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Area2D_body_entered(_body):
	$Label.visible = true	
	interact = 1

func _on_Area2D_body_exited(_body):
	$Label.visible = false
	interact = 0


func _physics_process(_delta):
	if Input.is_action_pressed("ui_accept") and interact and !get_parent().get_parent().dialogue:
		get_parent().get_parent().dialogue = 1
		if !get_milk:
			
			get_milk = 1
			# Add milk to inv later
			var add = get_parent().get_parent().get_node("Cat").get_item(milk)
			if add:
				var dialog = Dialogic.start('GetMilk')
				dialog.connect("dialogic_signal", self, "dialog_listener")
				add_child(dialog)
				get_parent().get_parent().get_node("MilkSprite").visible = false
			else:
				var dialog = Dialogic.start('InvFull')
				dialog.connect("dialogic_signal", self, "dialog_listener")
				add_child(dialog)
				
		else:
			var dialog = Dialogic.start('NoMilk')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)
		
func dialog_listener(string):
	
	match string:
		"end":
			print("dialog end")
			get_parent().get_parent().dialogue = 0
