extends Node2D

var inventory = preload("res://playerinv.tres")
var dialogue = 0
var give = 0
var read_potion = 0
var read_flower = 0
var check_flower = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue = 1
	var new_dialog = Dialogic.start('Chapter1')
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)
	
func dialog_listener(string):
	match string:
		"end":
			print("dialog end")
			dialogue = 0

