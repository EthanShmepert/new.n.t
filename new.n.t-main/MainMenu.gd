extends Control

func _ready():
    $VBoxContainer/Button.pressed.connect(_on_start_game_pressed)
    $VBoxContainer/Button2.pressed.connect(_on_options_pressed)
    $VBoxContainer/Button3.pressed.connect(_on_quit_pressed)

func _on_start_game_pressed():
    print("Start pressed!")
    get_tree().change_scene_to_file("res://Menus/final_maps.tscn")

func _on_options_pressed():
    print("Options pressed!")

func _on_quit_pressed():
    get_tree().quit()
