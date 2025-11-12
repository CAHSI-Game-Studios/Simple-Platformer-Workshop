extends Control


func _on_Try_again_pressed() -> void:
	get_tree().change_scene_to_file("res://src/Scenes/Levels/RoomTemplate.tscn")



func _on_quit_pressed() -> void:
	get_tree().quit()
