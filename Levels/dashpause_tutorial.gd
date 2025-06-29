extends Area2D


func _ready() -> void:
	var tween = create_tween()
	tween.tween_property($"../Control-Dash2", "modulate:a", 0.0, 0.0)


func _on_body_entered(body: Node2D) -> void:
	$"../../Player".pauseVelocity()
	$"../../SIGN_3 - Dash/Area2D2"._on_body_exited(null)
	var tween = create_tween()
	tween.tween_property($"../Control-Dash2", "modulate:a", 1.0, 1.3)


func _on_body_exited(body: Node2D) -> void:
	$"../../Player".resumeVelocity() # Replace with function body.
	var tween = create_tween()
	tween.tween_property($"../Control-Dash2", "modulate:a", 0.0, 1.0)
