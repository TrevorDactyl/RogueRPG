extends Player
class_name battleManager

var activeWindow : int = 0
var activeTarget : int = 0
var menuDepth : Array

var testEnemies : Array = [preload("res://Battle/Actors/Enemies/TestEnemy/TestEnemy.tres"),
 preload("res://Battle/Actors/Enemies/TestEnemy/TestEnemy.tres"),
 preload("res://Battle/Actors/Enemies/TestEnemy/TestEnemy.tres")]

var testParty : Array = [preload("res://Battle/Actors/Allies/Wilhelm/Wilhelm.tres"),
 preload("res://Battle/Actors/Allies/Wilhelm/Wilhelm.tres"),
 preload("res://Battle/Actors/Allies/Wilhelm/Wilhelm.tres"),
 preload("res://Battle/Actors/Allies/Wilhelm/Wilhelm.tres")]



#A list of enemy actors
var enemies : Array[ActorContainer]
var enemiesBars : Array
#A list of player actors
var party : Array[ActorContainer]
#A combined list of all actors
var actors : Array[ActorContainer]

@export var partyMarkers : MarkerLeader
@export var troopMarkers : MarkerLeader

@export var actorWindows : Control
var actorWindowList : Array

@export var stateMachine : Node
@export var menuMngr : menuManager

var setupComplete : bool = false

#Use to track how many player actors have finished their turn
var playerActorTurns : int = 0

@export var baseAttack : Skill
var selectedPlayerAction : Skill

func _ready():
	for index in range (Global.partySize+1):
		menuDepth.push_back(0)
	stateMachine.init(self)
	#Likely needs to be ran off a signal later, to ensure the party and enemy arrays are loaded first.
	var delay : Timer = Timer.new()
	delay.wait_time = 0.1
	delay.one_shot = true
	add_child(delay)
	delay.start()
	await delay.timeout
	setup()
	

#Run all setup functions for the current battle
func setup() -> void:
	SignalBus.beginAttack.connect(beginTargeting)
	gatherPlayerActors(testParty)
	gatherEnemyActors(testEnemies)
	gatherActorWindows()
	drawPlayerActors()
	drawActorWindows()
	drawEnemyActors()
	setupComplete = true

#Gather an array of player actors, ensuring that the base actors in the party are not changed.
func gatherPlayerActors(partyIn : Array) -> void:
	for index in range(partyIn.size()):
		var dupeActor : ActorContainer = ActorContainer.new()
		dupeActor.actor = partyIn[index].duplicate()
		party.push_back(dupeActor)
		party[index].combatID = index
		party[index].actor.hitSignal.connect(hit)



#Gather an array of enemies
func gatherEnemyActors(troopIn : Array) -> void:
	for index in range(troopIn.size()):
		var dupeActor : ActorContainer = ActorContainer.new()
		dupeActor.actor = troopIn[index].duplicate()
		enemies.push_back(dupeActor)
		enemies[index].combatID = index
		enemies[index].actor._init()

func gatherActorWindows() -> void:
	for index in range(actorWindows.get_child_count()):
		actorWindowList.push_back(actorWindows.get_child(index))


func drawPlayerActors() -> void:
	for index in range(party.size()):
		party[index].actor.instanceSprite(get_parent())
		party[index].actor.sprite.global_position = partyMarkers.markerList[index].global_position
		party[index].actor.sprite.originPosition = partyMarkers.markerList[index].global_position

func drawActorWindows() -> void:
	for index in range(party.size()):
		actorWindowList[index].setIcon(party[index].actor.icon)
		actorWindowList[index].setName(party[index].actor.name)
		actorWindowList[index].setHP(party[index].actor.hp, party[index].actor.hp_max)
		actorWindowList[index].setMP(party[index].actor.mp, party[index].actor.mp_max)

func drawEnemyActors() -> void:
	for index in range(enemies.size()):
		enemies[index].actor.instanceSprite(get_parent())
		enemies[index].actor.sprite.global_position = troopMarkers.markerList[index].global_position
		var enemyHPBar : ProgressBar = ProgressBar.new()
		get_parent().add_child(enemyHPBar)
		enemyHPBar.max_value = enemies[index].actor.hp_max
		enemyHPBar.global_position = enemies[index].actor.sprite.global_position + Vector2(-32, 36)
		enemyHPBar.theme = get_parent().theme
		enemyHPBar.show_percentage = false
		enemyHPBar.value = (enemies[index].actor.hp)
		enemyHPBar.size = Vector2(64, 8)
		enemiesBars.push_back(enemyHPBar)

func nextWindow(index : int) -> void:
	actorWindowList[activeWindow].dropIcon()
	var nextWin = activeWindow + index
	if nextWin > party.size()-1:
		nextWin = 0
	if nextWin < 0:
		nextWin = party.size()-1
	for jindex in party.size()-1:
		if party[nextWin].turnTaken:
			nextWin += index
	
	
	activeWindow = nextWin
	if activeWindow > Global.partySize:
		activeWindow = 0
	if activeWindow < 0:
		activeWindow = Global.partySize

func nextTarget(index : int) -> void:
	activeTarget += index
	if activeTarget > enemies.size()-1:
		activeTarget = 0
	if activeTarget < 0:
		activeTarget = enemies.size()-1

func toggleActionsWindow(visible : String) -> void:
	if visible == "show":
		actorWindowList[activeWindow].showCommandMenu()
	if visible == "hide":
		actorWindowList[activeWindow].hideCommandMenu()

func updateEnemyBar() -> void:
	for index in range(enemies.size()):
		if enemiesBars[index].value <= 0:
			return
		enemiesBars[index].value = (enemies[index].actor.hp)

func beginTargeting() -> void:
	stateMachine.current_state = stateMachine.targetState

func beginAttack() -> void:
	return

func useSkill(spell : Skill, casterContainer : ActorContainer, targetContainer : ActorContainer) -> void:
	var caster : BattleActor = casterContainer.actor
	var target : BattleActor = targetContainer.actor
	var damage = spell.formula.damage(caster.attack, caster.magAttack, target.defense, target.magDefense)
	var moveToPos : Vector2 = target.sprite.global_position ##Please fix##
	moveToPos.x += target.spriteSize.x
	caster.moveToLoc = moveToPos
	caster.currentAction = selectedPlayerAction
	
	caster.passTarget(targetContainer, damage)
	caster.attackNow()
	casterContainer.turnTaken = true
	menuMngr.disableActorWindow(activeWindow)
	#damage += randi_range((damage*0.1), (damage*0.01))
	#target.hp -= damage
	updateEnemyBar()

func hit(target : ActorContainer, damage : int):
	target.actor.hp -= damage + randi_range((damage*0.1), (damage*0.09))
	updateEnemyBar()

func _process(delta):
	if !setupComplete:
		return
	stateMachine.process_physics(delta)
	
	actorWindowList[activeWindow].raiseIcon()
