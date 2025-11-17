extends Node3D

const TURRET_PROJECTILE = preload("uid://563ue053bg5k")

@export var weapons_track_target: bool = false
@export var targeted_node: Node3D
@export var shoot_speed: float = 5.0
@export var attack_telegraph_time: float = 2.0
@export var time_between_shoots: float = 3.0
@onready var face: Node3D = %Face
@onready var shoot_spawn_position: Marker3D = %ShootSpawnPosition
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func smoothed_look_at(node_to_rotate: Node3D, point_to_look_at: Vector3, weight: float) -> void:
	var node_transform = node_to_rotate.global_transform
	var target_transform := node_transform.looking_at(point_to_look_at)
	var new_quaternion := Quaternion(node_transform.basis).slerp(Quaternion(target_transform.basis), weight)
	var new_transform := Transform3D(Basis(new_quaternion), node_transform.origin)
	node_to_rotate.global_transform = new_transform

func _ready() -> void:
	switch_to_aggresive_mode_animation()

func _physics_process(delta: float) -> void:
	look_at_target(delta)

func switch_to_aggresive_mode_animation():
	animation_player.play("switch_to_aggresive")

func switch_to_idle_mode_animation():
	animation_player.play_backwards("switch_to_aggresive")

func look_at_target(delta: float):
	if targeted_node:
		var point_to_look_at := targeted_node.global_position
		smoothed_look_at(face, point_to_look_at, 1 - pow(0.01, delta))
		if weapons_track_target:
			for weapon in face.weapons:
				smoothed_look_at(weapon, point_to_look_at, 1 - pow(0.01, delta))

func shoot():
	for weapon in face.weapons:
		weapon.play_shoot_animation()
	await get_tree().create_timer(attack_telegraph_time).timeout
	var turret_projectile = TURRET_PROJECTILE.instantiate()
	get_parent().add_child(turret_projectile)
	turret_projectile.global_position = shoot_spawn_position.global_position
	turret_projectile.direction = shoot_spawn_position.global_position.direction_to(targeted_node.global_position)
	turret_projectile.speed = shoot_speed
