extends State

var inputBuffer : Timer = Timer.new()

#The variable; targetMode, sets the way targeting is handeled...
#"SingleEnemy" allows the player to shift through enemies to target
#"SingleAlly" allows the player to shift through allies to target
#"AllEnemies" auto targets all enemies, but allows for a final confirmation
#"AllAllies" auto targets all allies, but allows for a final confirmation
#"Self" auto targets the caster, but allows for a final confirmation
var targetMode : String = "SingleEnemy" #Implement later

@export var playerTurn : State

func enter() -> void:
	inputBuffer.wait_time = 0.2
	inputBuffer.one_shot = true
	add_child(inputBuffer)


func exit() -> void:
	pass

func process_physics(delta: float) -> State:
	parent.menuMngr.processTarget()
	#Target selected
	#An assumption is made that the player is using an ability if they press action
	#-therefor, we can grab the ability from the parent
	if Input.is_action_just_pressed("Action"):
		parent.useSkill(parent.selectedPlayerAction,parent.party[parent.activeWindow] ,parent.enemies[parent.activeTarget])
		parent.party[parent.activeWindow].turnTaken = true
		parent.menuMngr.closeSubmenu(parent.activeWindow)
		parent.nextWindow(1)
		parent.selectedPlayerAction = null
		return playerTurn
	#Target Canceled
	if Input.is_action_just_pressed("Cancel"):
		parent.selectedPlayerAction = null
		return playerTurn
	
	
	return null
