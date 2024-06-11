extends Area2D
@onready var timer = $Timer
@onready var collision = $CollisionShape2D

@onready var apple = $"."
@onready var animation_player = $AnimationPlayer



func _on_body_entered(body):
	animation_player.play("pick_up")
	pass # Replace with function body.



func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
