extends Node2D

func _ready() -> void:
	var Lvl_List = $Control/Node.get_children()

	for i in range(9):
		if i+1 > SaveManager.getCurrentUnlockedLevels():
			Lvl_List[i].modulate = Color(0.3, 0.3, 0.3, 1)
		else:
			Lvl_List[i].modulate = Color(1, 1, 1, 1)
		
		Lvl_List[i].gui_input.connect(_on_texture_clicked.bind( int(Lvl_List[i].name) ))

	


func _on_texture_clicked(event, level):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if level <= SaveManager.getCurrentUnlockedLevels():
			get_tree().change_scene_to_file("res://Levels/Level_" + str(level) + ".tscn")
		
