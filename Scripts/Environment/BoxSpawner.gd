extends Spatial

export(String, FILE) var BoxScene;

func _ready():
	BoxScene = load(BoxScene);
	
	var thread = Thread.new();
	thread.start(self, "_thread_loop", thread);

func _thread_loop(v):
	var nextSpawn = 0.0;
	
	while true:
		if (GameManager == null):
			continue;
		
		if (GameManager.GameState != GameManager.GameStates.Playing):
			continue;
		
		var time = OS.get_ticks_msec()/1000.0;
		
		if (time > nextSpawn):
			spawn_box();
			nextSpawn = time + 0.5;
	
	v.wait_to_finish();

func spawn_box():
	var spawnPos = Vector3();
	spawnPos.x = rand_range(-10.0, 10.0);
	spawnPos.y = 12.0;
	spawnPos.z = 0.0;
	
	var instance = BoxScene.instance();
	instance.set_name("Box");
	instance.set_translation(spawnPos);
	add_child(instance);
