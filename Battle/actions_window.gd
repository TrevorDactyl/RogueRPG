extends NinePatchRect
class_name ActionWindow

@onready var atk_button = $VBoxContainer/AtkButton
@onready var skll_button = $VBoxContainer/SkllButton
@onready var item_button = $VBoxContainer/ItemButton
@onready var dfd_button = $VBoxContainer/DfdButton

var currentButton : Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_atk_button_pressed():
	#To be recieved by the battle state machine.
	SignalBus.beginAttack.emit()
