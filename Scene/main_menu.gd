extends Node2D

func _on_touch_screen_button_released():
	get_tree().change_scene_to_file("res://Scene/level1.tscn")


func _on_touch_screen_button_2_released():
	get_tree().quit()
