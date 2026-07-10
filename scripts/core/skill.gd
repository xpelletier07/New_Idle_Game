#extends Node
#


extends Resource
class_name Skill

@export var skill_id: String = ""
@export var skill_name: String = ""
@export var icon: Texture2D

var xp: float = 0.0
var level: int = 1

signal leveled_up(new_level)
signal xp_changed(current_xp, xp_for_next_level)

func xp_required_for_level(lvl: int) -> float:
	return 50.0 * lvl * lvl  # courbe simple, tu pourras l'ajuster plus tard

func add_xp(amount: float) -> void:
	xp += amount
	var next_level_xp = xp_required_for_level(level)
	while xp >= next_level_xp:
		xp -= next_level_xp
		level += 1
		leveled_up.emit(level)
		next_level_xp = xp_required_for_level(level)
	xp_changed.emit(xp, next_level_xp)
