extends Node3D

var direction: Vector3
var speed: float
@onready var hit_box: Area3D = $HitBox
@onready var terrain_collision: Area3D = $TerrainCollision

func _ready():
	hit_box.body_entered.connect(func(body):
		body.get_hit()
	)
	terrain_collision.body_entered.connect(func(_body):
		queue_free()
	)

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
