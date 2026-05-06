extends Node

var enemies: Dictionary = {
	"TestEnemy": BattleActor.new(),
	"TestEnemy2": BattleActor.new(),
}

func _ready() -> void:
	Utility.set_keys_to_names(enemies)
