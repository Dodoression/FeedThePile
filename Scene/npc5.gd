extends Sprite2D
var timer
@onready var panel = $Panel
@onready var rich_text_label = $RichTextLabel
@onready var audio_stream_player_2d = $AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.wait_time = 18.0
	timer.one_shot = true
	add_child(timer)


func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D" && GameManager.kg >= 300):
		rich_text_label.visible = true
		panel.visible = true
		fade_in_label(rich_text_label, 15.0)
		timer.start()
		timer.timeout.connect(on_timer_timeout)
		audio_stream_player_2d.play()
		

func fade_in_label(label: RichTextLabel, duration: float) -> void:
	var time_passed = 0.0
	while time_passed < duration:
		var ratio = time_passed / duration
		rich_text_label.visible_ratio = ratio
		await get_tree().process_frame  # Wait for the next frame
		time_passed += get_process_delta_time()  # Update the elapsed time
	label.visible_ratio = 1.0  # Ensure the final ratio is set to 1.0

func on_timer_timeout():
	get_tree().change_scene_to_file("res://Scene/boss.tscn")
