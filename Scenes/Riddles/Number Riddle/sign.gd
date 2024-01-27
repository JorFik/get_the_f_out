extends TileMap

signal correct

var input1: String = ""
var input2: String = ""
var input3: String = ""

func _process(_delta):
	if input1 == "8" and input2 == "7" and input3 == "3":
		correct.emit()
func _on_input_output(text):
	input1 = text

func _on_input_2_output(text):
	input2 = text

func _on_input_3_output(text):
	input3 = text
