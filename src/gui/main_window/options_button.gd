extends MenuButton

@export var about_window : Window

func _ready() -> void:
	get_popup().id_pressed.connect(_on_button_id_pressed)
	
func _on_button_id_pressed(index : int) -> void:
	match index:
		0:
			about_window.visible = !about_window.visible
