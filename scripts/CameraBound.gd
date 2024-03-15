extends Area2D


func _on_CameraBound_body_entered(_body:KinematicBody2D):
	get_parent().get_node("Cat/Camera2D").current = false


func _on_CameraBound_body_exited(_body:KinematicBody2D):
	get_parent().get_node("Cat/Camera2D").current = true
