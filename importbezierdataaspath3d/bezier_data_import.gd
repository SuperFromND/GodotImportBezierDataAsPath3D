@tool
extends EditorPlugin
var dock

func _enter_tree() -> void:
	dock = preload("res://addons/importbezierdataaspath3d/panel.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_LEFT_BR, dock)

func _exit_tree() -> void:
	remove_control_from_docks(dock)
	dock.free()
