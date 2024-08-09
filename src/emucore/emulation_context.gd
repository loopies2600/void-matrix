extends RefCounted
class_name EmulationContext

var paused : bool = false
var running : bool = false
var elapsed : int = 0

func emu_cycles(cpu_cycles : int) -> void:
	pass
