extends Control


@onready var audio_stream_player = $AudioStreamPlayer


func _on_button_play_pressed():
	audio_stream_player.playing = true
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn");


func _on_button_option_pressed():
	audio_stream_player.playing = true


func _on_button_quit_pressed():
	audio_stream_player.playing = true
	get_tree().quit()
