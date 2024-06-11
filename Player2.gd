extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $Sprite2D
@onready var collision_shape= $Sprite2D/MyHitBox/CollisionShape2D

const SPEED = 150
const JUMP_VELOCITY = -300.0
var side
var attacking:bool
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	get_floor_normal()
	if not is_on_floor():
		velocity.y += gravity * delta
		animation_player.play("jump")
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("attack") :
		attacking = true
		animation_player.play("attack")
		#move_and_slide()
		velocity = Vector2.ZERO
	else:
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			if direction >0:
				side ="right"
				collision_shape.position.x = abs(collision_shape.position.x)
				animated_sprite_2d.flip_h = false
			else:
				animated_sprite_2d.flip_h = true
				collision_shape.position.x = -abs(collision_shape.position.x)
				side ="left"
			if is_on_floor() and not attacking:
				animation_player.play("run")
			if  attacking:
				velocity.x = direction * SPEED/2.5
			else:
				velocity.x = direction * SPEED
		else:
			if is_on_floor() and not attacking:
				animation_player.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()

func disable_attack():
	attacking = false
