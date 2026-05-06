extends DamageFormula
class_name AttackFormula

func damage(aAtk : int, aMag : int, bDef :int, bMDF : int) -> int:
	var finalVal = (aAtk * 2)/bDef
	return finalVal
