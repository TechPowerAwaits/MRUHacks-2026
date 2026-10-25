extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_start_game() -> void:
	pass # Replace with function body.

func show_scene(name: String):
	for child in get_children():
		if child.name == name:
			child.show()
		else:
			child.hide()
