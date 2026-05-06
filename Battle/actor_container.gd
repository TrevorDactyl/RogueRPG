extends Resource
## An object that holds a reference to an actor, intended to be stored in an array of actors
class_name ActorContainer

@export var actor : BattleActor
## Has the actor finished their turn?
@export var turnTaken : bool = false
@export var combatID : int
