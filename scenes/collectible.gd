extends Area2D

signal object_collected()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		emit_signal("object_collected")
		queue_free()
