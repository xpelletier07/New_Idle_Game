extends Node

signal item_added(item: Item, quantity: int)

var skills: Dictionary = {}    # "foraging" -> Skill
var inventory: Dictionary = {} # nom de l'item -> quantité
var gold: int = 0

func _ready():
	skills["foraging"] = Skill.new()
	skills["foraging"].skill_name = "Foraging"

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
