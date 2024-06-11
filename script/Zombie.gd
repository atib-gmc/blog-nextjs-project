extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var zombie = $"."
@onready var ray_cast_right = $RayCastRight
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_left = $RayCastLeft
@onready var attack_timer = $Attack_timer
@onready var animation_player = $AnimationPlayer
@onready var zombie_collision_shape = $CollisionShape2D



var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player :CharacterBody2D = null
var player_attackable:bool = false
var cooldown :bool
var health:= 50
var player_attack:Attack =null
var direction = 40
var knockback_duration:float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <=0:
		animation_player.play("death")
		zombie_collision_shape.disabled = true
		return
	if knockback_duration > 0:
		knockback_duration -= delta
		animation_player.play("take_damage")
		velocity = (global_position - player_attack.position).normalized() * player_attack.knockback_force
		velocity.y = 100
		move_and_slide()
	
	#if player_attack:
		#velocity = (global_position - player_attack.position).normalized() * player_attack.knockback_force 
		#animation_player.play("take_damage")
		#move_and_slide()
		
	#if player and (ray_cast_left.is_colliding() or ray_cast_right.is_colliding()):
		#if player.position.x < position.x:
			#zombie.position.x -= (player.position.x - zombie.position.x) /direction
		#else:
			#zombie.position.x += (player.position.x - zombie.position.x) /direction
	#else:
		#if not ray_cast_right.is_colliding():
			##$Hit_Box/CollisionShape2D.position.x = -3
			#direction =  -40
			#animated_sprite.flip_h = true
			##collision_shape.position.x = -abs(collision_shape.position.x)
		#elif not ray_cast_left.is_colliding():
			#direction = 40
			##$Hit_Box/CollisionShape2D.position.x = 3			
			##collision_shape.position.x = abs(collision_shape.position.x)
			#animated_sprite.flip_h = false
		#position.x += direction * delta
		#animated_sprite.play("run")
		#pass

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
func take_damage(attack:Attack):
	if health<=0:
		animation_player.play("death")
	move_and_slide()
	health-= attack.damage
	player_attack = attack
	knockback_duration = .5
	#move_toward(global_position.x, attack.position.x)
	#global_position += (global_position - attack.position).normalized() * 40
	#velocity = (global_position - attack.position).normalized() * 600
	print("take damage", health)
