extends Node2D

func pauseVelocity() -> void:
    var tween = create_tween()
    tween.tween_property($CharacterBody2D, "velocity", Vector2(0, 0), .2)
    $CharacterBody2D.canWalk = false
    $CharacterBody2D.canJump = false
    $CharacterBody2D.dashBuffer = 0
    $CharacterBody2D.dashCount = 1
    $CharacterBody2D.canDash = true
    print("paused")

func resumeVelocity() -> void:
    $CharacterBody2D.canWalk = true
    $CharacterBody2D.canJump = true
    $CharacterBody2D.canDash = true
