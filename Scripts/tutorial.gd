extends Node2D


func _process(delta: float) -> void:
	if $Player.get_child(0).position.y > 800:
		$Player.get_child(0).position = Vector2(0, 0)
