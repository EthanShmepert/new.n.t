extends Sprite2D

var show

func _ready() -> void:
	show = false
	$".".self_modulate.a = 0

func _process(delta: float) -> void:
	if show == true and $".".self_modulate.a != 1:
		$".".self_modulate.a += delta * 10


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body is mainPlayer:
		show = true
