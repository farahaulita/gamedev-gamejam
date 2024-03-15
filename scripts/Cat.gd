extends KinematicBody2D
export (int) var speed = 400
var velocity = Vector2()
export (Array, Resource) var inv 
var inv_open = 0
onready var is_dialog = get_parent().dialogue


func get_input():
	var animation = "default"
	velocity.x = 0
	if Input.is_action_pressed("ui_right") and !inv_open and !get_parent().dialogue:
		$AnimatedSprite.flip_h = true
		animation = "walk"
		velocity.x += speed
				
	# move left		
	if Input.is_action_pressed("ui_left") and !inv_open and !get_parent().dialogue:
		$AnimatedSprite.flip_h = false
		animation = "walk"
		velocity.x -= speed		
	# Double Press Check
	
	if $AnimatedSprite.animation != animation:
		$AnimatedSprite.play(animation)

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

func get_item(item: InvItem):
	var ind = -1
	for i in range(12):
		if inv[i] == null:
			ind = i
			break
			
	if ind >= 0:
			inv[ind] = item
			return 1
	else:
		return 0

func count_item(id: InvItem):
	var count = 0
	for i in range(12):
		if inv[i] != null:
			if inv[i] == id:
				count = count + 1
	return count
	
func remove_item(id: InvItem):
	var ind = -1
	for i in range(12):
		if inv[i] != null:
			if inv[i] == id:
				ind = i
				break	
	if ind >= 0:
			inv[ind] = null
			return 1
	else:
		return 0
	
