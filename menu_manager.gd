extends Node
class_name menuManager

var inputBuffer : Timer = Timer.new()

@export var battleMngr : battleManager

func init() -> void:
	inputBuffer.wait_time = 0.2
	inputBuffer.one_shot = true
	add_child(inputBuffer)


func processMenu():
	var menuNav : int = Input.get_axis("MenuTabLeft", "MenuTabRight")
	
	if inputBuffer.is_stopped():
		battleMngr.nextWindow(menuNav)
	if menuNav != 0 && inputBuffer.is_stopped():
		inputBuffer.start()
	
	if Input.is_action_just_pressed("Down") and battleMngr.menuDepth[battleMngr.activeWindow] == 0:
		battleMngr.toggleActionsWindow("show")
	if Input.is_action_just_pressed("Cancel"):
		battleMngr.toggleActionsWindow("hide")
	return

func processTarget():
	var menuNav : int = Input.get_axis("MenuTabLeft", "MenuTabRight")
	
	if inputBuffer.is_stopped():
		battleMngr.nextTarget(menuNav)
	if menuNav != 0 && inputBuffer.is_stopped():
		inputBuffer.start()

#Closes all sub-menus for a given index
func closeSubmenu(index : int):
	battleMngr.actorWindowList[index].hideCommandMenu()

func disableActorWindow(index : int):
	closeSubmenu(index)
	battleMngr.actorWindowList[index].toggleIconWindow()
