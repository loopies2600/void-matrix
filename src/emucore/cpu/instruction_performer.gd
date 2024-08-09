extends RefCounted
class_name InstructionPerformer

# Shares same order as Opcode.InstructionTypes
var PERFORMERS : Array[Callable] = [
	perform_none,
	perform_nop,
	perform_ld,
	perform_inc,
	perform_dec,
	perform_rlca,
	perform_add,
	perform_rrca,
	perform_stop,
	perform_rla,
	perform_jr,
	perform_rra,
	perform_daa,
	perform_cpl,
	perform_scf,
	perform_ccf,
	perform_halt,
	perform_adc,
	perform_sub,
	perform_sbc,
	perform_and,
	perform_xor,
	perform_or,
	perform_cp,
	perform_pop,
	perform_jp,
	perform_push,
	perform_ret,
	perform_cb,
	perform_call,
	perform_reti,
	perform_ldh,
	perform_jphl,
	perform_di,
	perform_ei,
	perform_rst,
	perform_err,
	# CB PrefixedInstructions
	perform_rlc,
	perform_rrc,
	perform_rl,
	perform_rr,
	perform_sla,
	perform_sra,
	perform_swap,
	perform_srl,
	perform_bit,
	perform_res,
	perform_set
]

var cpu : SmCPU

func _init(_my_cpu : SmCPU):
	cpu = _my_cpu
	
func check_condition() -> bool:
	var flag_z : bool = BitwiseUtil.isBitEnabled(cpu.f, cpu.FlagList.ZERO)
	var flag_c : bool = BitwiseUtil.isBitEnabled(cpu.f, cpu.FlagList.CARRY)
	
	match cpu.current_instruction.condition_type:
		Opcode.ConditionTypes.CT_NONE:
			return true
		Opcode.ConditionTypes.CT_C:
			return flag_c
		Opcode.ConditionTypes.CT_NC:
			return not flag_c
		Opcode.ConditionTypes.CT_Z:
			return flag_z
		Opcode.ConditionTypes.CT_NZ:
			return not flag_z
	
	return false
	
func perform_none() -> void:
	print("not an instruction")
	
func perform_nop() -> void:
	print("Implement NOP")
	
func perform_ld() -> void:
	print("Implement LD")
	
func perform_inc() -> void:
	print("Implement INC")
	
func perform_dec() -> void:
	print("Implement DEC")
	
func perform_rlca() -> void:
	print("Implement RLCA")
	
func perform_add() -> void:
	print("Implement ADD")
	
func perform_rrca() -> void:
	print("Implement RRCA")
	
func perform_stop() -> void:
	print("Implement STOP")
	
func perform_rla() -> void:
	print("Implement RLA")
	
func perform_jr() -> void:
	print("Implement JR")
	
func perform_rra() -> void:
	print("Implement RRA")
	
func perform_daa() -> void:
	print("Implement DAA")
	
func perform_cpl() -> void:
	print("Implement CPL")
	
func perform_scf() -> void:
	print("Implement SCF")
	
func perform_ccf() -> void:
	print("Implement CCF")
	
func perform_halt() -> void:
	print("Implement HALT")
	
func perform_adc() -> void:
	print("Implement ADC")
	
func perform_sub() -> void:
	print("Implement SUB")
	
func perform_sbc() -> void:
	print("Implement SBC")
	
func perform_and() -> void:
	print("Implement AND")
	
func perform_xor() -> void:
	print("Implement XOR")
	
func perform_or() -> void:
	print("Implement OR")
	
func perform_cp() -> void:
	print("Implement CP")
	
func perform_pop() -> void:
	print("Implement POP")
	
func perform_jp() -> void:
	if check_condition():
		cpu.program_counter = cpu.fetch_data
		cpu.emu.context.emu_cycles(1)
	
func perform_push() -> void:
	print("Implement PUSH")
	
func perform_ret() -> void:
	print("Implement RET")
	
func perform_cb() -> void:
	print("Implement CB")
	
func perform_call() -> void:
	print("Implement CALL")
	
func perform_reti() -> void:
	print("Implement RETI")
	
func perform_ldh() -> void:
	print("Implement LDH")
	
func perform_jphl() -> void:
	print("Implement JPHL")
	
func perform_di() -> void:
	print("Implement DI")
	
func perform_ei() -> void:
	print("Implement EI")
	
func perform_rst() -> void:
	print("Implement RST")
	
func perform_err() -> void:
	print("Implement ERR")
	
func perform_rlc() -> void:
	print("Implement RLC")
	
func perform_rrc() -> void:
	print("Implement RRC")
	
func perform_rl() -> void:
	print("Implement RL")
	
func perform_rr() -> void:
	print("Implement RR")
	
func perform_sla() -> void:
	print("Implement SLA")
	
func perform_sra() -> void:
	print("Implement SRA")
	
func perform_swap() -> void:
	print("Implement SWAP")
	
func perform_srl() -> void:
	print("Implement SRL")
	
func perform_bit() -> void:
	print("Implement BIT")
	
func perform_res() -> void:
	print("Implement RES")
	
func perform_set() -> void:
	print("Implement SET")
	
