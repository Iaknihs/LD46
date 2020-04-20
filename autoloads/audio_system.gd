extends Node


onready var player = $player

onready var s1_1 = preload("res://assets/audio/rise_and_shine.wav")
onready var s1_2 = preload("res://assets/audio/enough_playing_dead.wav")
onready var s1_3 = preload("res://assets/audio/what_are_you_lying_around_for.wav")

onready var s2_1 = preload("res://assets/audio/get_back_to_work.wav")
onready var s2_2 = preload("res://assets/audio/stop_being_lazy.wav")
onready var s2_3 = preload("res://assets/audio/who_allowed_you_to_die.wav")

onready var s3_1 = preload("res://assets/audio/common_you_can_manage_a_bit_more.wav")
onready var s3_2 = preload("res://assets/audio/let_you_rest_when_done.wav")
onready var s3_3 = preload("res://assets/audio/not_you_time_yet.wav")

onready var s4_1 = preload("res://assets/audio/why_do_i_even_care.wav")
onready var s4_2 = preload("res://assets/audio/i_was_only_gone_for_a_few_days.wav")
onready var s4_3 = preload("res://assets/audio/now_everyone_is_gone.wav")

onready var s5_1 = preload("res://assets/audio/you_may_rest.wav")
onready var s5_2 = preload("res://assets/audio/will_try_to_manage_without_you.wav")
onready var s5_3 = preload("res://assets/audio/who_did_this.wav")

onready var s0_1 = preload("res://assets/audio/over_there.wav")
onready var s0_2 = preload("res://assets/audio/go_here.wav")
onready var s0_3 = preload("res://assets/audio/get_moving.wav")

enum sounds {
	stage_1,
	stage_2,
	stage_3,
	stage_4,
	stage_5,
	call
}

var ids = [0, 0, 0, 0, 0, 0]

func _play_sound(sound):
	match sound:
		sounds.stage_1:
			player.stream = [s1_1, s1_2, s1_3][ids[0]]
			ids[0] = (ids[0] + 1) % 3
		sounds.stage_2:
			player.stream = [s2_1, s2_2, s2_3][ids[1]]
			ids[1] = (ids[1] + 1) % 3
		sounds.stage_3:
			player.stream = [s3_1, s3_2, s3_3][ids[2]]
			ids[2] = (ids[2] + 1) % 3
		sounds.stage_4:
			player.stream = [s4_1, s4_2, s4_3][ids[3]]
			ids[3] = (ids[3] + 1) % 3
		sounds.stage_5:
			player.stream = [s5_1, s5_2, s5_3][ids[4]]
			ids[4] = (ids[4] + 1) % 3
		sounds.call:
			player.stream = [s0_1, s0_2, s0_3][ids[5]]
			ids[5] = (ids[5] + 1) % 3
	player.play()
