extends Menu


@export var icon : Sprite2D
@export var iconBox : NinePatchRect
@export var nameLabel : Label
@export var hpBar : ProgressBar
@export var mpBar : ProgressBar
@export var limitBar : ProgressBar

@export var iconPosUp : Vector2
@export var iconPosDown : Vector2

@export var iconWindow : NinePatchRect
@export var iconWindowDark : NinePatchRect

@export var actions_window : PackedScene
var newActionWindow

#Depth used to track which window is open.
# 0 - Base Window (No sub-menu  open)
# 1 - Actions Window
var windowDepth = 0

func setIcon(iconSprite : Texture) -> void:
	icon.texture = iconSprite

func setName(actorName : String) -> void:
	nameLabel.text = actorName

func setHP(newHP : int, maxHP : int) -> void:
	hpBar.value = maxHP / newHP * 100

func setMP(newMP : int, maxMP : int) -> void:
	mpBar.value = maxMP / newMP * 100


func raiseIcon() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(iconBox, "position", iconPosUp, 0.05)
	#iconBox.position = iconPosUp

func dropIcon() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(iconBox, "position", iconPosDown, 0.05)
	#iconBox.position = iconPosDown

func showCommandMenu() -> void:
	if newActionWindow != null:
		return
	newActionWindow = actions_window.instantiate()
	add_child(newActionWindow)
	newActionWindow.visible = true
	

func hideCommandMenu() -> void:
	if newActionWindow == null:
		return
	remove_child(newActionWindow)
	newActionWindow = null

func toggleIconWindow() -> void:
	iconWindowDark.draw_center = !iconWindowDark.draw_center
