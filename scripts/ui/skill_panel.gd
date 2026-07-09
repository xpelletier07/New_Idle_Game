#extends Control


extends Control

@export var skill_id: String = "Foraging"
@export var action: SkillAction

@onready var action_progress_bar: ProgressBar = $VBoxContainer/ActionProgressBar
@onready var xp_bar: ProgressBar = $VBoxContainer/XpBar
@onready var level_label: Label = $VBoxContainer/LevelLabel
@onready var action_button: Button = $VBoxContainer/ActionButton

var skill: Skill
var progress: float = 0.0
var is_active: bool = false

func _ready():
	skill = PlayerData.get_skill(skill_id)
	skill.xp_changed.connect(_on_xp_changed)
	skill.leveled_up.connect(_on_leveled_up)
	action_button.pressed.connect(_on_action_button_pressed)
	action_button.text = action.action_name
	_update_level_label()

func _process(delta):
	if is_active:
		progress += delta
		action_progress_bar.value = (progress / action.duration) * 100.0
		if progress >= action.duration:
			_complete_action()

func _on_action_button_pressed():
	is_active = !is_active

func _complete_action():
	progress = 0.0
	skill.add_xp(action.xp_reward)
	PlayerData.add_item(action.item_reward, action.item_quantity)

func _on_xp_changed(current_xp, xp_needed):
	xp_bar.value = (current_xp / xp_needed) * 100.0

func _on_leveled_up(_new_level):
	_update_level_label()

func _update_level_label():
	level_label.text = "%s - Niveau %d" % [skill.skill_name, skill.level]
