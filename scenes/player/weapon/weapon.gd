class_name Weapon
extends Resource

const PlayerFps = preload("uid://cm6bvjjhychqi")

@export var fire_rate: float = 10
@export var shoot_impulse: float = 20.0
@export var max_recoil_angle: float = PI / 10
@export var bullet_impulse: float = 100.0
@export var shoot_mode: PlayerFps.ShootMode = PlayerFps.ShootMode.HITSCAN
@export var weapon_model: PackedScene
