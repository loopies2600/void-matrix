extends RefCounted
class_name Opcode

# fetching modes
enum AddressingModes {
	AM_IMP,
	AM_R_D16,
	AM_R_R,
	AM_MR_R,
	AM_R,
	AM_R_D8,
	AM_R_MR,
	AM_R_HLI,
	AM_R_HLD,
	AM_HLI_R,
	AM_HLD_R,
	AM_R_A8,
	AM_A8_R,
	AM_HL_SPR,
	AM_D16,
	AM_D8,
	AM_D16_R,
	AM_MR_D8,
	AM_MR,
	AM_A16_R,
	AM_R_A16
}

enum RegisterTypes {
	RT_NONE,
	RT_A,
	RT_F,
	RT_B,
	RT_C,
	RT_D,
	RT_E,
	RT_H,
	RT_L,
	RT_AF,
	RT_BC,
	RT_DE,
	RT_HL,
	RT_SP, # stack pointer
	RT_PC # program counter
}

enum InstructionTypes {
	IN_NONE,
	IN_NOP,
	IN_LD,
	IN_INC,
	IN_DEC,
	IN_RLCA,
	IN_ADD,
	IN_RRCA,
	IN_STOP,
	IN_RLA,
	IN_JR,
	IN_RRA,
	IN_DAA,
	IN_CPL,
	IN_SCF,
	IN_CCF,
	IN_HALT,
	IN_ADC,
	IN_SUB,
	IN_SBC,
	IN_AND,
	IN_XOR,
	IN_OR,
	IN_CP,
	IN_POP,
	IN_JP,
	IN_PUSH,
	IN_RET,
	IN_CB,
	IN_CALL,
	IN_RETI,
	IN_LDH,
	IN_JPHL,
	IN_DI,
	IN_EI,
	IN_RST,
	IN_ERR,
	# CB instructions
	IN_RLC,
	IN_RRC,
	IN_RL,
	IN_RR,
	IN_SLA,
	IN_SRA,
	IN_SWAP,
	IN_SRL,
	IN_BIT,
	IN_RES,
	IN_SET
}

enum ConditionTypes {
	CT_NONE, CT_NZ, CT_Z, CT_NC, CT_C
}

var instruction_type : InstructionTypes
var addressing_mode : AddressingModes
var register_type_1 : RegisterTypes
var register_type_2 : RegisterTypes
var condition_type : ConditionTypes
var parameter : int

func _init(_in_type : InstructionTypes = 0, _am : AddressingModes = 0, _reg_type_1 : RegisterTypes = 0, _reg_type_2 : RegisterTypes= 0, _cond_type : ConditionTypes = 0, _param := 0) -> void:
	instruction_type = _in_type
	addressing_mode = _am
	register_type_1 = _reg_type_1
	register_type_2 = _reg_type_2
	condition_type = _cond_type
	parameter = _param
