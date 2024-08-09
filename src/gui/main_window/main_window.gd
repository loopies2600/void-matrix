extends Control

@onready var blast_particles : GPUParticles2D = $BlastParticles
@onready var about_window : Window = $AboutWindow

func _ready() -> void:
	var a := 0b11000000
	var b := 0b00001100
	
	var result := (b << 16) | a
	
	var binary : String = String.num_int64(result, 2)
	print(binary.length())
	0b1_1_0_0_0_0_0_0_0_0_0_0_1_1_0_0
	
	var hide_about := func(): about_window.hide()
	
	blast_particles.show()
	
	about_window.position = (get_window().size / 2.0) - (about_window.get_size_with_decorations() / 2.0)
	about_window.close_requested.connect(hide_about)
	
func _physics_process(delta: float) -> void:
	blast_particles.position = get_window().size / 2.0
