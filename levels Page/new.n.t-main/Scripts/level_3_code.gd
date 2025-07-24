extends Node

var emptied_items
var correctAnswers

var dropMoney

func _ready() -> void:
	emptied_items = false
	dropMoney = false
	correctAnswers = 0
	
func _process(delta: float) -> void:
	var metalDetectorBarrier = $"../MetalDetectorBody/MetalDetectorBody/StaticBody2D/CollisionShape2D"
	if emptied_items and not metalDetectorBarrier.disabled:
		metalDetectorBarrier.disabled = true
		$"../MetalDetectorBody/RedLight".visible = false
	
	if dropMoney:
		$"../Money".position.y += delta * 500	
	

	


func _on_area_2d_body_entered(body: Node2D) -> void:
	emptied_items = true


func _on_money_drop_body_entered(body: Node2D) -> void:
	dropMoney = true
