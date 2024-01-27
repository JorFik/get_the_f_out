extends Node2D

signal output(text: String)

func _on_line_edit_text_changed(new_text):
	$Label.text = new_text
	output.emit(new_text)
