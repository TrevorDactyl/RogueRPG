extends Node
class_name MarkerLeader

@export var markerCount : int = 4

var markerList : Array

func gatherMarkers() -> void:
	for i in get_children():
		markerList.push_back(i)

func _ready():
	gatherMarkers()
