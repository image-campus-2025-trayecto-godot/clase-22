extends Node3D

func play_shoot_animation():
	$AnimationPlayer.seek(0.0)
	$AnimationPlayer.play("shoot")
