extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
@onready var rich_text_label = $"../Node2D/Node/RichTextLabel"
@onready var panel = $"../Node2D/Node/Panel"
@onready var animated_sprite_2d = $AnimatedSprite2D



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	rich_text_label.visible = false
	panel.visible = false
	animated_sprite_2d.play("idle")
	
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
			animated_sprite_2d.flip_h =  true
		if (direction > 0):
			animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	if velocity.x == 0 and is_on_floor():
		animated_sprite_2d.play("idle")
	
	if not is_on_floor():
		animated_sprite_2d.pause()
