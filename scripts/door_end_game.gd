extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D

@export var nextScene = "res://scenes/menu.tscn";

func _on_body_entered(body):
	if body.name != "CharacterBodyPlayer":
		return 0
	animated_sprite_2d.play("default")
	await animated_sprite_2d.animation_finished
	get_tree().change_scene_to_file(nextScene)
