extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var zombie = $"."
@onready var ray_cast_right = $RayCastRight
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_left = $RayCastLeft
@onready var collision_shape = $Detection_area/CollisionShape2D
@onready var attack_timer = $Attack_timer

var player :CharacterBody2D = null
var player_attackable:bool = false
var cooldown :bool

var direction = 40
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_attackable and player and not cooldown:
		cooldown = true
		animated_sprite.play("attack")
		player.take_damage(1)
		attack_timer.start()
		return
	else :
		if player and (ray_cast_left.is_colliding() or  ray_cast_right.is_colliding()):
			if player.position.x < position.x:
				zombie.position.x -= (player.position.x - zombie.position.x) /direction
			else:
				zombie.position.x += (player.position.x - zombie.position.x) /direction
		else:
			if not ray_cast_right.is_colliding():
				#$Hit_Box/CollisionShape2D.position.x = -3
				direction =  -40
				animated_sprite.flip_h = true
				collision_shape.position.x = -18
			elif not ray_cast_left.is_colliding():
				direction = 40
				#$Hit_Box/CollisionShape2D.position.x = 3			
				collision_shape.position.x = 18
				animated_sprite.flip_h = false
			position.x += direction * delta
			animated_sprite.play("run")
			pass

func _on_detection_area_body_entered(body):
	if body:
		player = body
		pass # Replace with function body.


func _on_detection_area_body_exited(body):
	player = null
	pass # Replace with function body.

#//player enter
func _on_hit_box_body_entered(body):
	player_attackable = true
	pass # Replace with function body.

#player exit hit_box
func _on_hit_box_body_exited(body):
	player_attackable = false
	pass # Replace with function body.

#timer damage
func _on_attack_timer_timeout():
	cooldown = false
	pass # Replace with function body.
