extends State

@export var enemyTurn : State
@export var targetTurn : State

var proceedToTarget : bool = false

func _ready():
	SignalBus.beginAttack.connect(whenBeginAttackRecieved)

func enter() -> void:
	pass


func exit() -> void:
	pass

func process_physics(delta: float) -> State:
	if parent.selectedPlayerAction != null:
		return targetTurn
	
	parent.menuMngr.processMenu()
	
	if parent.playerActorTurns == parent.party.size():
		return enemyTurn
	return null

func whenBeginAttackRecieved():
	parent.selectedPlayerAction = parent.baseAttack
