extends Control

const MAIN_SCENE = "res://Scenes/Main.tscn"

func _ready():
	pass

func switch_scene():
	get_tree().change_scene(MAIN_SCENE);
