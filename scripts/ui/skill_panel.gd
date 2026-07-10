extends Control
class_name SkillPanel

@export var skill_id: String = "foraging"
@export var actions: Array[SkillAction] = []

@onready var skill_name_label: Label = $VBoxContainer/Header/SkillNameLabel
@onready var level_label: Label = $VBoxContainer/Header/LevelLabel
@onready var xp_bar: ProgressBar = $VBoxContainer/Header/XpBar
@onready var actions_container: GridContainer = $VBoxContainer/ScrollContainer/ActionsContainer

const ActionCardScene = preload("res://scenes/ui/skill_panel/action_card.tscn")

var skill: Skill
var current_action: SkillAction = null
var current_card: ActionCard = null
var progress: float = 0.0

func _ready():
	skill = PlayerData.get_skill(skill_id)
	skill.xp_changed.connect(_on_xp_changed)
	skill.leveled_up.connect(_on_leveled_up)
	skill_name_label.text = skill.skill_name
	_update_level_label()
	_populate_actions()

func _populate_actions():
	for action in actions:
		var card: ActionCard = ActionCardScene.instantiate()
		actions_container.add_child(card)
		card.setup(action)
		card.action_pressed.connect(_on_action_pressed)

func _on_action_pressed(action: SkillAction):
	if current_action == action:
		current_action = null
		if current_card:
			current_card.set_active(false)
			current_card.set_progress(0)
		current_card = null
		progress = 0.0
		return

	if current_card:
		current_card.set_active(false)
		current_card.set_progress(0)

	current_action = action
	progress = 0.0
	current_card = _find_card_for_action(action)
	if current_card:
		current_card.set_active(true)

func _find_card_for_action(action: SkillAction) -> ActionCard:
	for card in actions_container.get_children():
		if card.action == action:
			return card
	return null

func _process(delta):
	if current_action and current_card:
		progress += delta
		current_card.set_progress((progress / current_action.duration) * 100.0)
		if progress >= current_action.duration:
			_complete_action()

func _complete_action():
	progress = 0.0
	skill.add_xp(current_action.xp_reward)
	PlayerData.add_item(current_action.item_reward, current_action.item_quantity)

func _on_xp_changed(current_xp, xp_needed):
	xp_bar.value = (current_xp / xp_needed) * 100.0

func _on_leveled_up(_new_level):
	_update_level_label()

func _update_level_label():
	level_label.text = "Niveau %d" % skill.level
