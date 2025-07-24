extends Area2D

var fade = 0


func _ready() -> void:
	var tween = create_tween()
	tween.tween_property($"../Control", "modulate:a", 0.0, 0.0)

func _on_body_entered_dash(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($"../Control", "modulate:a", 1.0, 1.0)
	
func _on_body_exited(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($"../Control", "modulate:a", 0.0, 1.0)
