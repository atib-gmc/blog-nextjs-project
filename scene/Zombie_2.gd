extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var player_detection_collision = $Player_detection/CollisionShape2D
@onready var platform_detection = $Sprite2D/Platform_detection
@onready var player_detection = $Player_detection

var player:CharacterBody2D =null
var speed = 40
var health = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_attack:Attack= null
var knockback_timer := 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#print(not is_on_floor())
	get_floor_normal()
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.x = move_toward(velocity.x, 0, speed)
		move_and_slide()
	if player :
		velocity -= (global_position - player.position).normalized() 
		flip_char(player.position.x,position.x)
		animation_player.play("run")
	else:
		velocity.y += gravity * delta
		#velocity = Vector2.ZERO 
		animation_player.play("idle")
	move_and_slide()
	pass

func take_damage(attack:Attack):
	player_attack = attack
	self.modulate  = "#fff"
	#if attack.position.x < position.x:
	flip_char(attack.position.x,position.x)	
	velocity = (global_position - attack.position).normalized() * 100
	move_and_slide()
	
#detect if player enter sight
func _on_player_detection_body_entered(body):
	player = body
	pass # Replace with function body.

#detect if player leaving 
func _on_player_detection_body_exited(body):
	player = null
	pass # Replace with function body.


#fungsi untuk memflip character
func flip_char(target:float,char:float):
	if char > target:
		sprite_2d.flip_h = true
		player_detection_collision.position.x = -abs(player_detection_collision .position.x)
	else:
		sprite_2d.flip_h = false
		player_detection_collision.position.x = abs(player_detection_collision .position.x)
func enemy():
	pass
