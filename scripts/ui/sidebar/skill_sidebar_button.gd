extends Button
class_name SkillSidebarButton

signal pressed_with_id(skill_id: String)

@onready var icon_rect: TextureRect = $HBoxContainer/Icon
@onready var name_label: Label = $HBoxContainer2/NameLabel
@onready var level_label: Label = $HBoxContainer2/LevelLabel

var skill_id: String
var skill: Skill

func setup(id: String, s: Skill) -> void:
	skill_id = id
	skill = s
	name_label.text = skill.skill_name
	icon_rect.texture = skill.icon
	level_label.text = "Niveau %d" % skill.level
	skill.leveled_up.connect(_on_leveled_up)
	pressed.connect(func(): pressed_with_id.emit(skill_id))

func _on_leveled_up(new_level):
	level_label.text = "Niveau %d" % new_level
