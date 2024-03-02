extends KinematicBody2D
export (int) var speed = 300
var velocity = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = true
		velocity.x += speed
			
	
		
	# move left		
	if Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = false
		velocity.x -= speed
		
	# Double Press Check
	

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
