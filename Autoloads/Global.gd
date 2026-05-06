extends Node

const GAME_SIZE: Vector2 = Vector2(640, 360)
const GAME_SIZE_HALVED: Vector2 = GAME_SIZE * 0.5



var cursor: Node = null
var camera: Camera2D = null
var event_log: Label = null

#Lower by 1 because of functions that start from zero
var partySize : int = 3

func _ready() -> void:
	randomize()
