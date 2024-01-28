extends TileMap

signal correct

var input1: String = ""
var input2: String = ""
var input3: String = ""
var input4: String = ""

func _process(_delta):
	if input1 == "1" and input2 == "2" and input3 == "3" and input4 == "7":
		correct.emit()
func _on_input_output(text):
	input1 = text

func _on_input_2_output(text):
	input2 = text

func _on_input_3_output(text):
	input3 = text


func _on_input_4_output(text):
	input4 = text
