extends Control




func _on_exit_button_pressed():
	get_tree().quit()


func _on_retry_button_pressed():
	get_tree().change_scene("res://scenes/level1.tscn")
