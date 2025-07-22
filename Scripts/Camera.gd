extends Camera2D

func _process(delta: float) -> void:
	if $"..".position.y > 200:
		position_smoothing_speed = 0
	elif position_smoothing_speed != 10:
		position_smoothing_speed = 10
