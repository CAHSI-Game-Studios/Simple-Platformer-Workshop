extends Node2D


func _on_start_game_pressed():
	# when the "start game" button is pressed, the game changes to the main game scene
	get_tree().change_scene_to_file("res://src/Scenes/Levels/RoomTemplate.tscn")


func _on_quit_pressed():
	# when the "quit" button is pressed, it extis the game 
	get_tree().quit()
