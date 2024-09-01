extends RichTextLabel
@onready var rich_text_label = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	rich_text_label.text = "[b]Current pile weight: 100kg.[/b]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
