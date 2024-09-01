extends Sprite2D

@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var control = $"."

var frames = texture.get_width() / region_rect.size.x

func _ready():
	var random_index = randi_range(0, frames - 1)
	region_rect.position.x = random_index * region_rect.size.x

func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		print("om nom nom")
		GameManager.add_kg()
		audio_stream_player_2d.play()
		scale_down(0.3)

func scale_down(duration: float) -> void:
	var time_passed = 0.0
	while time_passed < duration:
		var ratio = 1.0 - (time_passed / duration)
		self.scale = Vector2(ratio, ratio)  # Assuming a 2D object, for 3D use Vector3(ratio, ratio, ratio)
		await get_tree().process_frame  # Wait for the next frame
		time_passed += get_process_delta_time()  # Update the elapsed time
	self.scale = Vector2(0.0, 0.0)  # Ensure the final scale is set to 0
	queue_free()
