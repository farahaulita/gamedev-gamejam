extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var inventory = preload("res://playerinv.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_dialog = Dialogic.start('Chapter1')
	add_child(new_dialog)
	
func add_item(item:InvItem):
	for i in range(inventory.size):
		if !inventory[i]:
			inventory[i] = item
			break
			
func remove_item(item:String):
	for i in range(inventory.size):
		var index = 0
		if inventory[i].name == item:
			index = i
			break
		inventory.remove(i)
			
			
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



		
