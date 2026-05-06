extends Resource
class_name Skill

@export var name : String = ""
@export var description : String = ""

@export var targetType : String = ""
@export_enum("Melee", "Magic", "Hybrid") var skillType: int
@export var manaCost : int = 0

@export var formula : DamageFormula
@export_enum("attack", "cast", "defend", "limit") var animationType : String
@export var animOverride : String
