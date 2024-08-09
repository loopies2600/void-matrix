extends Node
class_name EmulatorInstance

var context : EmulationContext = EmulationContext.new()
var rom_context : RomContext = RomContext.new()

var cpu : SmCPU = SmCPU.new()
var address_bus : AddressBus = AddressBus.new()

func get_context() -> EmulationContext:
	return context
	
func start_emulation() -> void:
	address_bus.rom_context = rom_context
	cpu.boot(self)
	
	context.running = true
	context.paused = false
	context.elapsed = 0
	
func _process(_delta: float) -> void:
	if context.running:
		cpu.tick()
