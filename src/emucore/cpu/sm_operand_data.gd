extends RefCounted
class_name SmOperandData

var immediate : bool
var base_name : StringName
var bytes : int
var value : int
var adjust : int # DEBE SER "+" "-" O NADA

func _init(_imt : bool = self.immediate, _nam : StringName = self.base_name, _byt : int = self.bytes, _val : int = self.value, _adj : int = self.adjust) -> void:
	immediate = _imt
	base_name = _nam
	bytes = _byt
	value = _val
	adjust = _adj
