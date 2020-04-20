extends Node2D


onready var timer = $Timer
onready var progress = $TextureProgress

func _on_skill_used():
	timer.wait_time = progress.max_value
	progress.value = progress.max_value
	timer.start()

func _process(delta):
	progress.value = ceil(timer.time_left)

func get_remaining_time():
	return timer.time_left
