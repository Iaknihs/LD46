extends Node2D


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_Button_pressed():
	OS.shell_open("https://github.com/Iaknihs/LD46")
