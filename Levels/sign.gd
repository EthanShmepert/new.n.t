extends Area2D
var isVisible
var fade = 0


func _ready() -> void:
	isVisible = false
	var tween = create_tween()
	tween.tween_property($"../Control", "modulate:a", 0.0, 0.0)

func _on_body_entered(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($"../Control", "modulate:a", 1.0, 1.0)

func _on_body_exited(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($"../Control", "modulate:a", 0.0, 1.0)
