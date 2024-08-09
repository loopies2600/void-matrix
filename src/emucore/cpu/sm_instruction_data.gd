extends RefCounted
class_name SmInstructionData

var opcode : int
var immediate : bool
var operands : Array[SmOperandData]
var cycles : PackedByteArray
var bytes : int
var mnemonic : StringName
var comment : StringName

func _init(_opc : int = self.opcode, _imt : bool = self.immediate, _ops : Array[SmOperandData] = self.operands, _cyc : PackedByteArray = self.cycles, _byt : int = self.bytes, _mon : StringName = self.mnemonic, _cmt : StringName = self.comment) -> void:
	opcode = _opc
	immediate = _imt
	operands = _ops
	cycles = _cyc
	bytes = _byt
	mnemonic = _mon
	comment = _cmt
	
func as_text() -> StringName:
	var base_text : StringName = ""
	
	base_text += "--- INSTRUCTION %s --\n" % opcode
	base_text += "immediate: %s\n" % immediate
	base_text += "operands: %s\n" % operands
	base_text += "cycles: %s\n" % cycles
	base_text += "bytes: %s\n" % bytes
	base_text += "mnemoric: %s\n" % mnemonic
	base_text += "comment: %s." % comment
	
	return base_text
