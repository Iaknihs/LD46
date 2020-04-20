extends Node2D


onready var emitter = $emitter

# Called when the node enters the scene tree for the first time.
func _ready():
	emitter.emitting = true


func _on_timer_timeout():
	queue_free()
