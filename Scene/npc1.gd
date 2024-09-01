extends Node2D
@onready var panel = $Node/Panel
@onready var rich_text_label = $Node/RichTextLabel
@onready var audio_stream_player_2d = $AudioStreamPlayer2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
		if (body.name == "CharacterBody2D"):
			rich_text_label.visible = true
			panel.visible = true
			fade_in_label(rich_text_label, 3.0)
			audio_stream_player_2d.play()


func _on_area_2d_body_exited(body):
	if (body.name == "CharacterBody2D"):
		rich_text_label.visible = false
		panel.visible = false

func fade_in_label(label: RichTextLabel, duration: float) -> void:
	var time_passed = 0.0
	while time_passed < duration:
		var ratio = time_passed / duration
		rich_text_label.visible_ratio = ratio
		await get_tree().process_frame  # Wait for the next frame
		time_passed += get_process_delta_time()  # Update the elapsed time
	label.visible_ratio = 1.0  # Ensure the final ratio is set to 1.0

