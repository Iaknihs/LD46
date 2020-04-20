extends Node2D

onready var health_over = $hp_progress
onready var health_under = $delayed_progress
onready var update_tween = $delay_tween

var offset = Vector2.ZERO
var inited = false


func _ready():
	offset = global_position - get_parent().global_position
	set_as_toplevel(true)

func _physics_process(delta):
	global_position = get_parent().global_position + offset

func init(min_health, max_health, curr_health):
	health_over.min_value = min_health
	health_under.min_value = min_health
	health_over.max_value = max_health
	health_under.max_value = max_health
	health_over.value = curr_health
	health_under.value = curr_health

func hitpoints_changed(new_health):
	health_over.value = new_health
	update_tween.stop_all()
	update_tween.interpolate_property(
		health_under,
		"value",
		health_under.value,
		new_health,
		0.4,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		0.2
	)
	update_tween.start()
