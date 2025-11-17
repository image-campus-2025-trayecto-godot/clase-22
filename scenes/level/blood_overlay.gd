extends TextureRect

@export var player: Player
var max_hp: float = 100.0

func _ready():
	if player:
		max_hp = player.MAX_HP
		player.hp_changed.connect(self.on_player_hp_changed)
	modulate.a = 0.0

func on_player_hp_changed(new_hp: float):
	modulate.a = 1 - new_hp / max_hp
