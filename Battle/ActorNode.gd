extends Node2D
##A node to handle all the movement of an actor's battle sprite##
class_name ActorNode


@export var hit : Signal

@export var target : ActorContainer
@export var damage : int
@export var animation : AnimationPlayer
@export var sprite : Sprite2D
#Where the actor should return to after an action
@export var originPosition : Vector2

signal moveFinished

#Functions to play specified animations
func attackAnim():
	animation.play("attack")

func castAnim():
	animation.play("cast")

func idleAnim():
	animation.play("idle")

func moveAnim():
	animation.play("move")


func sendHit():
	#Pass damage and a target up to the battle manager. Gets called in the Animation Player
	hit.emit(target, damage)

func emitMoveSignal():
	moveFinished.emit()

func moveToLocation(target : Vector2, attackAfter : bool = true):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target, 0.3)
	if attackAfter:
		tween.connect("finished", emitMoveSignal)
	tween.play()

func returnToOrigin():
	moveToLocation(originPosition, false)
	idleAnim()
