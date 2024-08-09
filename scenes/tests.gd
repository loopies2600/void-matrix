extends Node

func _ready() -> void:
	var value : int = 0xABCD
	
	print("raw ", value)
	print("war ", 0xCDAB)
	
	var flipped : int = (value & 0xFF00) >> 8 | (value & 0xFF) << 8
	
	print(flipped)
