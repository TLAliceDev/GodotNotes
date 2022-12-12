tool
extends Control

const notes_dir = "res://addons/godotes/Notes/"
const file_extension = ".txt"
const note_scene = preload("res://addons/godotes/Note.tscn")

var current_file = "Notes"

func _enter_tree():
	load_all_notes()

func savetext():
	var file = File.new()
	file.open(notes_dir+current_file+file_extension,File.WRITE)
	file.store_string($HBoxContainer/TextEdit.text)
	file.close()

func loadtext():
	var file = File.new()
	var file_path = notes_dir+current_file+file_extension
	file.open(file_path,File.READ)
	if file.file_exists(file_path):
		$HBoxContainer/TextEdit.text = file.get_as_text()
	else:
		file.close()
		file.open(file_path,File.WRITE)
		file.store_string("")
		$HBoxContainer/TextEdit.text = ""
	file.close()

func load_new_note(note_name):
	current_file = note_name
	loadtext()

func load_all_notes():
	var dir = Directory.new()
	if dir.open(notes_dir) == OK:
		dir.list_dir_begin(true)
		var file_name = dir.get_next()
		while file_name != "":
			var new_note = note_scene.instance()
			$HBoxContainer/ScrollContainer/VBoxContainer.add_child(new_note,false)
			if file_name.ends_with(file_extension):
				file_name = file_name.trim_suffix(file_extension)
			new_note.set_text(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()

func delete_note(note_name):
	var dir = Directory.new()
	dir.remove(notes_dir+note_name+file_extension)

func _on_ToolButton_pressed():
	savetext()
	$ConfirmationDialog/MarginContainer/TextEdit.text = " "
	$ConfirmationDialog.popup_centered(Vector2(320,120))

func _on_ConfirmationDialog_confirmed():
	savetext()
	current_file = $ConfirmationDialog/MarginContainer/TextEdit.text
	$HBoxContainer/TextEdit.text = ""
	savetext()
	var new_note = note_scene.instance()
	$HBoxContainer/ScrollContainer/VBoxContainer.add_child(new_note)
	new_note.set_text(current_file)
	loadtext()
