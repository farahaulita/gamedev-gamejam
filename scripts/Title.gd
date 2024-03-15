extends Node2D


func _physics_process(_delta):
	if Input.is_action_pressed("dialogic_default_action"):
		get_tree().change_scene("res://scenes/MainLevel.tscn")
	if Input.is_action_pressed("ui_end"):
		get_tree().quit()
