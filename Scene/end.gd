extends Node2D
@onready var rich_text_label = $RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	fade_in_label(rich_text_label, 7.0)

func fade_in_label(label: RichTextLabel, duration: float) -> void:
	var time_passed = 0.0
	while time_passed < duration:
		var ratio = time_passed / duration
		rich_text_label.visible_ratio = ratio
		await get_tree().process_frame  # Wait for the next frame
		time_passed += get_process_delta_time()  # Update the elapsed time
	label.visible_ratio = 1.0  # Ensure the final ratio is set to 1.0
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
