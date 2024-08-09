extends RefCounted
class_name SmCPU

enum FlagList {
	ZERO = 7,
	SUBSTRACTION = 6,
	HALF_CARRY = 5,
	CARRY = 4
}

# should be 256 entries wide
static var INSTRUCTIONS : Array[Opcode] = []

var emu : EmulatorInstance
var instruction_performer := InstructionPerformer.new(self)

# registers
# 8 BIT (can be accesed as 16 bit)
var a : int = 0
var f : int = 0 # FLAGS register
# bit 7: z (ZERO flag)
# bit 6: n (SUBSTRACTION flag)
# bit 5: h (HALF CARRY flag)
# bit 4: c (CARRY flag)
var b : int = 0
var c : int = 0
var d : int = 0
var e : int = 0
var h : int = 0
var l : int = 0
# 16 BIT
var program_counter : int = 0
var stack_pointer : int = 0

# cpu fetch data (16 BIT)
var fetch_data : int = 0
var mem_dest : int = 0
var destination_is_mem : bool = false

# current opcode (8 BIT)
var cur_opcode : int = 0

# instruction resource
var current_instruction : Opcode

# cpu state
var halted : bool = false
var stepping : bool = false
var do_master_interrupt : bool = false

func _init() -> void:
	_setup_instruction_set()
	
func _setup_instruction_set() -> void:
	INSTRUCTIONS.clear()
	INSTRUCTIONS.resize(0x100)
	
	# NOP
	INSTRUCTIONS[0x00] = Opcode.new(Opcode.InstructionTypes.IN_NOP, Opcode.AddressingModes.AM_IMP)
	# DEC B
	INSTRUCTIONS[0x05] = Opcode.new(Opcode.InstructionTypes.IN_DEC, Opcode.AddressingModes.AM_R, Opcode.RegisterTypes.RT_B)
	# LD C n8
	INSTRUCTIONS[0x0E] = Opcode.new(Opcode.InstructionTypes.IN_LD, Opcode.AddressingModes.AM_R_D8, Opcode.RegisterTypes.RT_C)
	# XOR A A
	INSTRUCTIONS[0xAF] = Opcode.new(Opcode.InstructionTypes.IN_XOR, Opcode.AddressingModes.AM_R, Opcode.RegisterTypes.RT_A)
	# JP NZ a16
	INSTRUCTIONS[0xC3] = Opcode.new(Opcode.InstructionTypes.IN_JP, Opcode.AddressingModes.AM_D16)
	# DI
	INSTRUCTIONS[0xF3] = Opcode.new(Opcode.InstructionTypes.IN_DI)
	
func boot(_emulator_instance : EmulatorInstance) -> void:
	emu = _emulator_instance
	
	# DMG entry point
	program_counter = 0x100
	
func read_register(reg_type : Opcode.RegisterTypes) -> int:
	match reg_type:
		# 8 bit read
		Opcode.RegisterTypes.RT_A:
			return a
		Opcode.RegisterTypes.RT_F:
			return f
		Opcode.RegisterTypes.RT_B:
			return b
		Opcode.RegisterTypes.RT_C:
			return c
		Opcode.RegisterTypes.RT_D:
			return d
		Opcode.RegisterTypes.RT_E:
			return e
		Opcode.RegisterTypes.RT_H:
			return h
		Opcode.RegisterTypes.RT_L:
			return l
		
		# 16 bit reads (BIG ENDIAN)
		Opcode.RegisterTypes.RT_AF:
			return (f << 8) | a
		Opcode.RegisterTypes.RT_BC:
			return (c << 8) | b
		Opcode.RegisterTypes.RT_DE:
			return (e << 8) | d
		Opcode.RegisterTypes.RT_HL:
			return (l << 8) | h
		
		Opcode.RegisterTypes.RT_SP:
			return stack_pointer
		Opcode.RegisterTypes.RT_PC:
			return program_counter
		
	return 0
	
func inst_fetch() -> void:
	cur_opcode = emu.address_bus.bus_read(program_counter)
	program_counter += 1
	
	if INSTRUCTIONS[cur_opcode] == null:
		return
	
	current_instruction = INSTRUCTIONS[cur_opcode]
	
func data_fetch() -> void:
	if current_instruction == null:
		return
	
	mem_dest = 0
	destination_is_mem = false
	
	match current_instruction.addressing_mode:
		Opcode.AddressingModes.AM_IMP:
			return
		
		Opcode.AddressingModes.AM_R:
			fetch_data = read_register(current_instruction.register_type_1)
			return
		
		Opcode.AddressingModes.AM_R_D8:
			fetch_data = emu.address_bus.bus_read(program_counter)
			emu.context.emu_cycles(1)
			program_counter += 1
			return
		
		Opcode.AddressingModes.AM_D16:
			var lo : int = emu.address_bus.bus_read(program_counter)
			emu.context.emu_cycles(1)
			
			var hi : int = emu.address_bus.bus_read(program_counter + 1)
			emu.context.emu_cycles(1)
			
			# 8 bits of each
			fetch_data = lo | (hi << 8)
			
			program_counter += 2
			return
	
func execute() -> void:
	var performer : Callable = instruction_performer.PERFORMERS[current_instruction.instruction_type]
	
	if performer == null:
		print("PERFORMER NOT FOUND.. instruction will not be executed")
	
	performer.call()
	
func tick() -> bool:
	if not halted:
		var pc_old : int = program_counter
		
		inst_fetch()
		data_fetch()
		
		var first_byte : int = emu.address_bus.bus_read(pc_old)
		var next_byte : int = emu.address_bus.bus_read(pc_old + 1)
		var rightmost_byte : int = emu.address_bus.bus_read(pc_old + 2)
		
		print("[0x%x] (%x %x %x) \tA: 0x%x \tF: 0x%x \tB: 0x%x \tC: 0x%x \tD: 0x%x \tE: 0x%x \tH: 0x%x \tL: 0x%x" % [pc_old, first_byte, next_byte, rightmost_byte, a, f, b, c, d, e, h, l])
		
		execute()
	
	return true
