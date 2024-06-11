extends Area2D
@onready var player = $"../Player"

@onready var timer = $Timer

func _on_body_entered(body):
	if body.has_method("enemy"):
		body.queue_free()
	else:
		timer.start()


func _on_timer_timeout():
	print("you're dead")
	get_parent().get_node("Player2").position = Vector2(10,-5)
	
	pass # Replace with function body.
