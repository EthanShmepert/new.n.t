extends Node2D

@onready var tween = create_tween()

var start_pos : Vector2
var end_pos : Vector2
var speed := 2.0  # seconds to move back and forth

func _ready():
    start_pos = position
    end_pos = position + Vector2(100, 0)  # move 100 pixels to the right
    start_movement()

func start_movement():
    tween.tween_property(self, "position", end_pos, speed).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
    tween.tween_property(self, "position", start_pos, speed).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
    tween.set_loops()  # repeat forever
