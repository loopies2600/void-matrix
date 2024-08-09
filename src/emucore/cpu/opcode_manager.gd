extends Node
class_name OpcodeManager

@export_file("*.json") var opcode_list_json : String = "res://src/emucore/cpu/opcodes.json"

var unprefixed_instructions : Array[SmInstructionData] = []
var cbprefixed_instructions : Array[SmInstructionData] = []

var _tablegen_start_time : int = 0
var _tablegen_end_time : int = 0

func parse_opcodes_json() -> void:
	var json_file : FileAccess = FileAccess.open(opcode_list_json, FileAccess.READ)
	
	var json : JSON = JSON.new()
	
	var err : Error = json.parse(json_file.get_as_text())
	
	# Si está listo, llenemos la table de instrucciones!
	if err == OK:
		populate_instruction_tables(json.data as Dictionary)
	
func populate_instruction_tables(optable : Dictionary) -> void:
	unprefixed_instructions.clear()
	cbprefixed_instructions.clear()
	
	unprefixed_instructions = _populate_table(optable.unprefixed)
	cbprefixed_instructions = _populate_table(optable.cbprefixed)
	
func _populate_table(optable : Dictionary) -> Array[SmInstructionData]:
	var instructions : Array[SmInstructionData] = []
	instructions.resize(0xFF + 1)
	
	var addresses : PackedStringArray = optable.keys() as PackedStringArray
	
	for i in 0xFF + 1:
		var inst_data : Dictionary = optable[addresses[i]]
		var new_instruction : SmInstructionData = SmInstructionData.new()
		
		new_instruction.opcode = i
		new_instruction.immediate = inst_data.immediate
		
		var inst_ops : Array[SmOperandData] = []
		
		for j in inst_data.operands.size():
			var operand : Dictionary = inst_data.operands[j]
			
			var new_operand : SmOperandData = SmOperandData.new()
			
			new_operand.base_name = operand.name
			new_operand.immediate = operand.immediate
			
			if operand.has("bytes"):
				new_operand.bytes = operand.bytes
			
			if operand.has("value"):
				new_operand.value = operand.value
			
			if operand.has("increment"):
				new_operand.adjust = 43 if operand.increment == true else 45
			
			inst_ops.push_back(new_operand)
			
		new_instruction.operands = inst_ops
		
		new_instruction.mnemonic = inst_data.mnemonic
		new_instruction.bytes = inst_data.bytes
		new_instruction.cycles = PackedByteArray(inst_data.cycles)
		
		instructions[i] = new_instruction
	
	return instructions
	
# Leer y validar el archivo json primero
func _ready() -> void:
	_tablegen_start_time = Time.get_ticks_msec()
	parse_opcodes_json()
	_tablegen_end_time = Time.get_ticks_msec()
	
	var elapsed : int = _tablegen_end_time - _tablegen_start_time
	print("instruction table setup took %s ms (%s seconds)." % [elapsed, float(elapsed) / 1000.0])
	
	print(unprefixed_instructions[0xFF].mnemonic)
