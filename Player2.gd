extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2d

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var side
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animation_player.play("jump")
		#animation_player.play("jump_down")
		#if velocity.y>0:
		#else :

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("attack") :
		animation_player.play("attack")
	else:
	# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions  with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			if direction >0:
				side ="right"
				animated_sprite_2d.flip_h = false
			else:
				animated_sprite_2d.flip_h = true
				side ="left"
			if is_on_floor():
				animation_player.play("walk")
			velocity.x = direction * SPEED
		else:
			if is_on_floor():
				animation_player.play("idle")			
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
