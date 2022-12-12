class_name GodoteNote
tool
extends HBoxContainer

func _enter_tree():
	$GodoteNote.text = name

func _on_GodoteNote_pressed():
	get_parent().get_parent().get_parent().get_parent().savetext()
	get_parent().get_parent().get_parent().get_parent().load_new_note($GodoteNote.text)


func _on_ToolButton_pressed():
	get_parent().get_parent().get_parent().get_parent().delete_note($GodoteNote.text)
	queue_free()

func set_text(text):
	$GodoteNote.text = text
	name = text
