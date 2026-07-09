#extends Node

extends Resource
class_name SkillAction

@export var action_name: String = ""
@export var duration: float = 3.0       # temps en secondes pour compléter
@export var xp_reward: float = 10.0
@export var item_reward: Item
@export var item_quantity: int = 1
@export var required_level: int = 1
