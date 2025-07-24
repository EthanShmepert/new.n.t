extends Camera2D

func _ready():
	var cam = $"."
	cam.make_current()
	cam.zoom = Vector2(.79, .79)  
	
