class_name WeaponController
extends Node3D
const PlayerFps = preload("uid://cm6bvjjhychqi")
@onready var weapon_pivot: Node3D = $".."

@export var weapon: Weapon :
	set(new_weapon):
		weapon = new_weapon
		if not is_node_ready():
			await ready
		spawn_weapon_model.call_deferred()
@export var weapon_mode: PlayerFps.WeaponMode = PlayerFps.WeaponMode.SemiAutomatic

signal weapon_model_changed(new_model)

func _ready():
	spawn_weapon_model.call_deferred()

func spawn_weapon_model():
	var old_weapon_model = weapon_pivot.get_node("WeaponModel")
	weapon_pivot.remove_child(old_weapon_model)
	old_weapon_model.queue_free()
	
	var new_weapon_model: Node3D = weapon.weapon_model.instantiate()
	weapon_pivot.add_child(new_weapon_model)
	new_weapon_model.name = "WeaponModel"
	weapon_model_changed.emit(new_weapon_model)

func max_recoil_angle() -> float:
	return weapon.max_recoil_angle

func bullet_impulse() -> float:
	return weapon.bullet_impulse

func shoot_mode() -> PlayerFps.ShootMode:
	return weapon.shoot_mode

func fire_rate() -> float:
	return weapon.fire_rate

func shoot_impulse() -> float:
	return weapon.shoot_impulse
