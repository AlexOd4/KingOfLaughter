extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/GameLevel.tscn")


func _on_options_pressed():
	pass # Replace with function bo
	
	

func _on_quit_pressed():
	get_tree().quit()