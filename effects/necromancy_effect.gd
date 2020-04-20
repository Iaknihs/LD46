extends Node2D

onready var emitter = $emitter

func _ready():
	emitter.emitting = true
	print("emitting necro effect at:")
	print(position)


func _on_Timer_timeout():
	print("removing necro effect")
	queue_free()
