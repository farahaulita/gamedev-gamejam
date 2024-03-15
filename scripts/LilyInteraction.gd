extends CollisionShape2D

var interact = 0
var lily_get = 0
var lily_potion = 0
var lily_ash = 0
	
onready var dialogue = get_parent().get_parent().dialogue
onready var growth = preload("res://items/growth.tres")
onready var ash = preload("res://items/ash.tres")
onready var lily = preload("res://items/Lily.tres")
var lily_bloom = load("res://assets/ItemToggles/LilyBloom.png") 
var lily_taken = load("res://assets/ItemToggles/LilyTaken.png") 
func _physics_process(_delta):
	if Input.is_action_pressed("ui_accept") and interact and !get_parent().get_parent().dialogue:
		get_parent().get_parent().dialogue = 1
		# Add Cooki
		if !get_parent().get_parent().read_flower:
			var dialog = Dialogic.start('Lily/LilyUnknown')
			dialog.connect("dialogic_signal", self, "dialog_listener")
			add_child(dialog)		
			if !get_parent().get_parent().check_flower:
				get_parent().get_parent().check_flower = 1	
				
		else:
			if !get_parent().get_parent().check_flower:
				get_parent().get_parent().check_flower = 1	
				var dialog = Dialogic.start('Lily/LilyIdentified')
				dialog.connect("dialogic_signal", self, "dialog_listener")
				add_child(dialog)		
				
			else:
				if !lily_ash and !lily_potion:
					var remove = get_parent().get_parent().get_node("Cat").remove_item(ash)
					if remove:
						var dialog = Dialogic.start('Lily/LilyAsh')
						dialog.connect("dialogic_signal", self, "dialog_listener")
						add_child(dialog)
						lily_ash = 1		
					else:
						var remove2 = get_parent().get_parent().get_node("Cat").remove_item(growth)
						if remove2:
							var dialog = Dialogic.start('Lily/LilyPotion')
							dialog.connect("dialogic_signal", self, "dialog_listener")
							add_child(dialog)
							lily_potion = 1
						else:
							var dialog = Dialogic.start('Lily/LilyIdentified')
							dialog.connect("dialogic_signal", self, "dialog_listener")
							add_child(dialog)
							
				elif lily_ash and !lily_potion:
					var remove = get_parent().get_parent().get_node("Cat").remove_item(growth)
					if remove:
						var dialog = Dialogic.start('Lily/LilyPotion')
						dialog.connect("dialogic_signal", self, "dialog_listener")
						add_child(dialog)
						lily_potion = 1
						#Change Sprite
						get_parent().get_parent().get_node("LilySprite").texture = lily_bloom
					else:
						var dialog = Dialogic.start('Lily/LilyIdentified')
						dialog.connect("dialogic_signal", self, "dialog_listener")
						add_child(dialog)
					
				elif lily_potion and !lily_ash:
					var remove = get_parent().get_parent().get_node("Cat").remove_item(ash)
					if remove:
						var dialog = Dialogic.start('Lily/LilyAsh')
						dialog.connect("dialogic_signal", self, "dialog_listener")
						add_child(dialog)
						lily_ash = 1
						#Change Sprite
						get_parent().get_parent().get_node("LilySprite").texture = lily_bloom
					else:
						var dialog = Dialogic.start('Lily/LilyIdentified')
						dialog.connect("dialogic_signal", self, "dialog_listener")
						add_child(dialog)
				else:
					if !lily_get:
						var add = get_parent().get_parent().get_node("Cat").get_item(lily)
						if add:
							var dialog = Dialogic.start('Lily/GetLily')
							dialog.connect("dialogic_signal", self, "dialog_listener")
							add_child(dialog)	
							lily_get =1
							#Change Sprite
							get_parent().get_parent().get_node("LilySprite").texture = lily_taken
						else:
							var dialog = Dialogic.start('InvFull')
							dialog.connect("dialogic_signal", self, "dialog_listener")
							add_child(dialog)
							
					else:
						var dialog = Dialogic.start('Lily/NoLily')
						dialog.connect("dialogic_signal", self, "dialog_listener")
						add_child(dialog)	
				
func dialog_listener(string):
	match string:
		"end":
			print("dialog end")
			get_parent().get_parent().dialogue = 0

func _on_Lily_body_entered(_body):
	$Label.visible = true	
	interact = 1

func _on_Lily_body_exited(_body):
	$Label.visible = false	
	interact = 0
