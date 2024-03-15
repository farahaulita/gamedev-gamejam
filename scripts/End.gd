extends Node2D

func _physics_process(_delta):
	if Input.is_action_pressed("ui_end"):
		get_tree().change_scene("res://scenes/Title.tscn")

