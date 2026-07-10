extends Node

signal item_added(item: Item, quantity: int)

#Pour ajouter un autre skill, ajouter un const du preload .tres et un _register_skill() dans _ready()
const FORAGING_SKILL := preload("res://resources/skills/foraging.tres")

var skills: Dictionary = {}
var inventory: Dictionary = {}
var gold: int = 0


func _ready():
	_register_skill(FORAGING_SKILL)

func _register_skill(skill: Skill) -> void:
	skills[skill.skill_id] = skill

func add_item(item: Item, quantity: int = 1) -> void:
	if item == null:
		return
	if inventory.has(item.item_name):
		inventory[item.item_name] += quantity
	else:
		inventory[item.item_name] = quantity
	item_added.emit(item, quantity)

func get_skill(skill_id: String) -> Skill:
	return skills.get(skill_id)
