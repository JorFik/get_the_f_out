extends Node2D

signal riddle_correct

func _on_sign_2_correct():
	riddle_correct.emit()
	print("ridle_correct signal emitted")
