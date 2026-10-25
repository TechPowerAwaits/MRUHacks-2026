extends Control


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scene_1.tscn")
