extends Node

# Nodes
var Interface;
var PlayerNode;
var TouchControl;

# Enums
enum Controller {
	Touch = 0,
	VirtualJoystick,
	DeviceTilt
};

enum GameStates {
	None = 0,
	Playing
};

# Variables
var IsMobile = false;
var ControllerType = Controller.Touch;
var GameState = GameStates.None;

func _ready():
	IsMobile = OS.get_name().to_lower() == "android";

func start_game():
	GameState = GameStates.Playing;
