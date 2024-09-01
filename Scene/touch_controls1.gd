extends Control
@onready var rich_text_label = $RichTextLabel
var kilos

func _ready():
	GameManager.connect("kg_changed", Callable(self, "_on_kg_changed"))

func _on_kg_changed(new_kg: int):
	# Update the RichTextLabel when the signal is received
	rich_text_label.text = " [b]Current pile weight: [/b]" + str(new_kg) + " kg."
