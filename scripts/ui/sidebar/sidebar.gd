extends VBoxContainer
class_name Sidebar

signal skill_selected(skill_id: String)

const SkillButtonScene = preload("res://scenes/ui/sidebar/skill_sidebar_button.tscn")

func _ready():
	for skill_id in PlayerData.skills:
		var skill: Skill = PlayerData.skills[skill_id]
		var btn: SkillSidebarButton = SkillButtonScene.instantiate()
		add_child(btn)
		btn.setup(skill_id, skill)
		btn.pressed_with_id.connect(func(id): skill_selected.emit(id))
