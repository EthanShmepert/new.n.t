extends Camera2D

func _physics_process(delta: float) -> void:
	if $"..".position.y > 200:
		position_smoothing_speed = 0
	elif position_smoothing_speed != 10:
		position_smoothing_speed = 10
		position_smoothing_enabled = true
		process_callback = Camera2D.CAMERA2D_PROCESS_PHYSICS
