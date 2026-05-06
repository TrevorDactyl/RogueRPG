extends Resource
class_name BattleActor

signal hit(target : ActorContainer, damage : int)
signal attackFinished()

@export var name: String = ""
@export var role: Array


#These are level 1 stats, they will be changed in the resource as the actor levels
@export var level: int = 1
@export var hp_max: int = 1
var hp: int = hp_max
@export var mp_max: int = 1
var mp: int = mp_max
@export var attack: int = 1
@export var defense: int = 1
@export var magAttack: int = 1
@export var magDefense: int = 1
@export var speed : int = 1

@export var skills : Array[Skill]
#The values in this array are added to random numbers for each stat, in the order above
@export var statGrowth : Array

@export var expGrowth : Array

@export var useSprite : PackedScene = null
var sprite : ActorNode
var spriteSize : Vector2
var moveToLoc : Vector2
signal hitSignal(target : ActorContainer, damage : int)
@export var icon : Texture

@export var currentAction : Skill

func _init(_hp: int = hp_max, _mp: int = mp_max) -> void:
	hp = _hp
	mp = _mp


func set_name_var(_name: String) -> void:
	name = _name

func instanceSprite(newParent : Node) -> void:
	sprite = useSprite.instantiate()
	newParent.add_child(sprite)
	sprite.hit = hitSignal
	spriteSize = sprite.sprite.texture.get_size()
	sprite.moveFinished.connect(proceedAttack)

func passTarget(targetN : ActorContainer, damageN : int):
	sprite.target = targetN
	sprite.damage = damageN

func attackNow():
	if currentAction.animOverride == null:
		return
	match currentAction.animationType:
		"attack":
			sprite.moveToLocation(moveToLoc)
		"cast":
			proceedAttack()


func proceedAttack(animType : String = "attack"):
	if animType == "cast":
		sprite.castAnim()
		return
	sprite.attackAnim()
