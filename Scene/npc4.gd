extends Sprite2D
@onready var rich_text_label = $Node/RichTextLabel
@onready var panel = $Node/Panel


func fade_in_label(label: RichTextLabel, duration: float) -> void:
	var time_passed = 0.0
	while time_passed < duration:
		var ratio = time_passed / duration
		rich_text_label.visible_ratio = ratio
		await get_tree().process_frame  # Wait for the next frame
		time_passed += get_process_delta_time()  # Update the elapsed time
	label.visible_ratio = 1.0  # Ensure the final ratio is set to 1.0


func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
			rich_text_label.visible = true
			panel.visible = true
			fade_in_label(rich_text_label, 3.0)


func _on_area_2d_body_exited(body):
	if (body.name == "CharacterBody2D"):
		rich_text_label.visible = false
		panel.visible = false
