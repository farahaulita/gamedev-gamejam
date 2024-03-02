extends CollisionShape2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var interact = 0
var dialogue = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body: KinematicBody2D):
	$Label.visible = true	
	interact = 1

func _on_Area2D_body_exited(body):
	$Label.visible = false
	interact = 0


func _physics_process(delta):
	if Input.is_action_pressed("ui_accept") and interact and !dialogue:
		dialogue = 1
		var dialog = Dialogic.start('Chapter1')
		add_child(dialog)
		
func dialog_listener(string):
	match string:
		"end":
			dialogue = 0
