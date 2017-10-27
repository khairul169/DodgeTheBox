extends Control

# Variables
var is_pressed = [false, false];
var touch_id = [null, null];

func _ready():
	# Register node
	GameManager.TouchControl = self;
	
	set_process_input(true);

func _input(ie):
	if (ie.type == InputEvent.SCREEN_TOUCH):
		if (ie.pressed):
			var mPos = ie.pos;
			if (get_rect().has_point(mPos)):
				if (mPos.x < get_global_rect().pos.x + get_global_rect().size.width/2.0):
					is_pressed[0] = true;
					touch_id[0] = ie.index;
				else:
					is_pressed[1] = true;
					touch_id[1] = ie.index;
		
		else:
			if (touch_id[0] == ie.index && is_pressed[0]):
				is_pressed[0] = false;
				touch_id[0] = null;
			
			if (touch_id[1] == ie.index && is_pressed[1]):
				is_pressed[1] = false;
				touch_id[1] = null;
