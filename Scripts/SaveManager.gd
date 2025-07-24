extends Node

var Players = {}
var CurrentPlayer

func isInPlayerList(player_name: String) -> bool:
    if player_name in Players.values():	
        return true
    return false

func save_game(player_name: String, level: int) -> void:
    var currState = load_game()
    if not isInPlayerList(player_name):	
        Players[player_name] = level
        
    var file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
    file.store_string(JSON.stringify(Players))
    file.close()

func load_game() -> Dictionary:
    if not FileAccess.file_exists("user://savegame.json"):
        
        return {}  # or return default values
    
    var file = FileAccess.open("user://savegame.json", FileAccess.READ)
    var data = file.get_as_text()
    file.close()
    
    Players = JSON.parse_string(data)
    if CurrentPlayer == null:
        var keys = Players.keys()
        CurrentPlayer = Players[keys[0]]
    return Players

func assignNewPlayer(player_name: String) -> void:
    CurrentPlayer = player_name
    if isInPlayerList(player_name):
        return	
    Players[player_name] = 9
    
func getCurrentUnlockedLevels() -> int:
    if load_game() == {}:
        assignNewPlayer("guest_user")
        load_game()
    return Players[CurrentPlayer]
    
