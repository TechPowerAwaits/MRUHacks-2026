extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Background.position = $Player.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Background.position.x = lerp($Background.position.x, $Player.position.x, 5 * delta)
	$Background.position.y = $Player.position.y
	pass
