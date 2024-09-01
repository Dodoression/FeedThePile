extends Node

var kg = 20
var rich_text_label

signal kg_changed(new_kg: int)

func add_kg():
	kg += 10
	print(kg)
	emit_signal("kg_changed", kg)
