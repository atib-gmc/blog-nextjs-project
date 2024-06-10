extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite = $AnimatedSprite2D
var side
@export var health = 8
var death = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = $"."


func _physics_process(delta):
	#print(self.position.x)
	# Add the gravity.
	if side =="left":
		animated_sprite.flip_h = false
	elif side == "right":
		animated_sprite.flip_h = true
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction>0 :
		side = "right"
		animated_sprite.flip_h = false
		animated_sprite.play("run")
	elif direction < 0:
		side ="left"
		animated_sprite.flip_h = true
		animated_sprite.play("run")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")
	move_and_slide()
	
	
func take_damage(amount:int):
	health -= 1
	velocity += Vector2(100,0).normalized() 
	if health <=0 :
		death = true
		animated_sprite.play("death")
		$CollisionShape2D.disabled = true			
		$Death_timer.start()
		return
	print("youre taking damag, your health is : ",health)

func _on_death_timer_timeout():
	get_tree().reload_current_scene()
	pass # Replace with function body.
