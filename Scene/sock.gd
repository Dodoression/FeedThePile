extends TouchScreenButton
var timer
@onready var panel = $"../../Panel"
@onready var rich_text_label = $"../../RichTextLabel"
@onready var node_2d = $".."
var second_dialogue = false
var third_dialogue = false

var attack_timer
var stopped_attacking = false
var play_once_bool = false

@onready var touch_screen_button = $"."


@onready var audio_stream_player_2d = $"../AudioStreamPlayer2D"

@onready var panel_2 = $"../../Panel2"
@onready var rich_text_label_2 = $"../../RichTextLabel2"

#var attack = preload("res://Scene/attack.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.wait_time = 12.0
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(on_timer_timeout)
	timer.start()
	move_node_to_position(node_2d, Vector2(-10, 110), 1.0)
	
	attack_timer = Timer.new()
	attack_timer.wait_time = 20.0
	attack_timer.one_shot = true
	add_child(attack_timer)
	attack_timer.timeout.connect(ending)
	attack_timer.start()


func fade_in_label(label: RichTextLabel, duration: float) -> void:
	var time_passed = 0.0
	while time_passed < duration:
		var ratio = time_passed / duration
		rich_text_label.visible_ratio = ratio
		await get_tree().process_frame  # Wait for the next frame
		time_passed += get_process_delta_time()  # Update the elapsed time
	label.visible_ratio = 1.0  # Ensure the final ratio is set to 1.0
	
	if (second_dialogue):
		move_node_to_position(node_2d, Vector2(230, 110), 1.0)
		move_node_between_positions(node_2d, Vector2(-250, 110), Vector2(230, 110), 2.0)
		panel.visible = false
		rich_text_label.visible = false

func move_node_to_position(node: Node2D, target_position: Vector2, duration: float) -> void:
	var time_passed = 0.0
	var start_position = node.position
	
	while time_passed < duration:
		var ratio = time_passed / duration
		node.position = start_position.lerp(target_position, ratio)
		await get_tree().process_frame  # Wait for the next frame
		time_passed += get_process_delta_time()  # Update the elapsed time
	
	if not second_dialogue:
		node.position = target_position  # Ensure the final position is exactly the target position
		panel.visible = true
		rich_text_label.visible = true
		fade_in_label(rich_text_label, 9.0)

	
func on_timer_timeout():
	panel.visible = false
	rich_text_label.visible = false
	rich_text_label.text = ". . . with MY SMELL.\n Now, FIGHT ME!!"
	panel.visible = true
	rich_text_label.visible = true
	fade_in_label(rich_text_label, 4.0)
	second_dialogue = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("sock")) && (stopped_attacking):
		rich_text_label_2.visible = false
		play_once()

func move_node_between_positions(node: Node2D, position_a: Vector2, position_b: Vector2, duration: float) -> void:
	var time_passed = 0.0
	var going_to_b = true  # Indicates whether the node is moving to position_b or back to position_a

	while not stopped_attacking:
		time_passed = 0.0
		var start_position = node.position
		var target_position = position_b if going_to_b else position_a
		
		while time_passed < duration:
			var ratio = time_passed / duration
			node.position = start_position.lerp(target_position, ratio)
			await get_tree().process_frame  # Wait for the next frame
			time_passed += get_process_delta_time()  # Update the elapsed time
		
		node.position = target_position  # Ensure the final position is set
		going_to_b = !going_to_b  # Toggle direction


func ending():
	print("came")
	stopped_attacking = true
	panel_2.visible = true
	rich_text_label_2.visible = true
	fade_in_label2(rich_text_label_2, 7.0)
	print("end")

func fade_in_label2(label: RichTextLabel, duration: float) -> void:
	var time_passed = 0.0
	print("func called")
	while time_passed < duration:
		var ratio = time_passed / duration
		rich_text_label_2.visible_ratio = ratio
		await get_tree().process_frame  # Wait for the next frame
		time_passed += get_process_delta_time()  # Update the elapsed time
	label.visible_ratio = 1.0  # Ensure the final ratio is set to 1.0
	panel_2.visible = false
	rich_text_label_2.text = "(Click on the sock)"
	
func play_once():
	if not play_once_bool:
		audio_stream_player_2d.play()
		play_once_bool = true
		rich_text_label.text = "          . . . . . . . . God damn, that fart was the worst thing I've smelled. . . What have you eaten, man??...."
		rich_text_label.visible = true
		panel.visible = true
		fade_in_label3(rich_text_label, 7.0)
		

func fade_in_label3(label: RichTextLabel, duration: float) -> void:
	var time_passed = 0.0
	print("func called")
	while time_passed < duration:
		var ratio = time_passed / duration
		rich_text_label.visible_ratio = ratio
		await get_tree().process_frame  # Wait for the next frame
		time_passed += get_process_delta_time()  # Update the elapsed time
	label.visible_ratio = 1.0  # Ensure the final ratio is set to 1.0
	panel.visible = false
	rich_text_label.visible = false
	touch_screen_button.visible = false
	get_tree().change_scene_to_file("res://Scene/end.tscn")
