extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d_2 = $AnimatedSprite2D2



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animated_sprite_2d_2.play("idle")
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("upArrow") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("leftArrow", "rightArrow")
	if direction:
		velocity.x = direction * SPEED
		if (direction < 0):
			animated_sprite_2d_2.flip_h =  true
		if (direction > 0):
			animated_sprite_2d_2.flip_h = false
		animated_sprite_2d_2.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	if velocity.x == 0 and is_on_floor():
		animated_sprite_2d_2.play("idle")
	
	if not is_on_floor():
		animated_sprite_2d_2.pause()

