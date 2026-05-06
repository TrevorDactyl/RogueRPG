extends Label
@export var battleManage : battleManager

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Active Target: " + str(battleManage.activeTarget)
