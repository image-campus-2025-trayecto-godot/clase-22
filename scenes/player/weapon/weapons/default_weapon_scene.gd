extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_shoot_animation():
	animation_player.play("shoot")

func play_toggle_weapon_animation():
	animation_player.play("toggle_weapon")
	await animation_player.animation_finished
