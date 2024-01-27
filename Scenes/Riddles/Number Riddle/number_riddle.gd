extends Node2D

signal riddle_correct

func _on_sign_correct():
	riddle_correct.emit()
	print("Riddle correction emitted")
