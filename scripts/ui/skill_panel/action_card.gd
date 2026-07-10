extends Button
class_name ActionCard

signal action_pressed(action: SkillAction)

@onready var icon_rect: TextureRect = $VBoxContainer/Icon
@onready var name_label: Label = $VBoxContainer/NameLabel
@onready var xp_label: Label = $VBoxContainer/XpLabel
@onready var progress_bar: ProgressBar = $VBoxContainer/ProgressBar

var action: SkillAction

func setup(new_action: SkillAction) -> void:
	action = new_action
	name_label.text = action.action_name
	xp_label.text = "%s XP" % str(action.xp_reward)
	if action.item_reward and action.item_reward.icon:
		icon_rect.texture = action.item_reward.icon
	progress_bar.value = 0
	pressed.connect(func(): action_pressed.emit(action))

func set_progress(value: float) -> void:
	progress_bar.value = value

func set_active(active: bool) -> void:
	modulate = Color(1, 1, 0.7) if active else Color(1, 1, 1)
