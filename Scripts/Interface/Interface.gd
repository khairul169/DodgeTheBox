extends Control

func _ready():
	GameManager.Interface = self;
	
	get_node("MainInterface/BtnPlay").connect("pressed", self, "play_game");

func play_game():
	GameManager.start_game();
	get_node("MainInterface").hide();
