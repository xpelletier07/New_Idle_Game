extends Control

@onready var tab_container: TabContainer = $HBoxContainer/TabContainer
@onready var sidebar: Sidebar = $HBoxContainer/Sidebar

func _ready():
	sidebar.skill_selected.connect(_on_skill_selected)

func _on_skill_selected(skill_id: String):
	for i in tab_container.get_child_count():
		var panel: SkillPanel = tab_container.get_child(i)
		if panel.skill_id == skill_id:
			tab_container.current_tab = i
			break
