class_name MyHitBox
extends Area2D
@export var Damage := 1



# Called when the node enters the scene tree for the first time.
func _init():
	collision_layer = 2
	collision_mask = 0 
	pass # Replace with function body.
