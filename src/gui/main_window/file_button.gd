extends MenuButton

@export var emulator : EmulatorInstance
@onready var rom_file_dialog = $FileDialog

func _ready() -> void:
	get_popup().id_pressed.connect(_on_button_id_pressed)
	
func _on_button_id_pressed(index : int) -> void:
	print(index)
	match index:
		0:
			rom_file_dialog.show()
			
			var path : String = await rom_file_dialog.file_selected
			
			emulator.rom_context.load_rom(path)
			emulator.start_emulation()
			$"../../../RomTitle".text = emulator.rom_context.header.as_text()
		1:
			get_tree().quit()
