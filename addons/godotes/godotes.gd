tool
extends EditorPlugin

var note_editor

func _enter_tree():
	note_editor = preload("res://addons/godotes/NotesDock.tscn").instance()
	note_editor.loadtext()
	get_editor_interface().get_editor_viewport().add_child(note_editor)
	make_visible(false)


func _exit_tree():
	if note_editor:
		note_editor.savetext()
		note_editor.free()
	pass

func has_main_screen():
	return true

func make_visible(visible):
	if note_editor:
		note_editor.savetext()
		note_editor.visible = visible

func get_plugin_name():
	return "Notes"
