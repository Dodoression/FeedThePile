extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if (self.visible):
		print("ok")
	velocity.y += gravity * delta

func _on_area_2d_body_entered(body):
	if (body.name == "CharacterBody2D"):
		print("-1 hp")
	else:
		print("floor")
