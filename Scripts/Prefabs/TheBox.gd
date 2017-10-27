extends RigidBody

func _ready():
	var randLV = Vector3(rand_range(-1.0, 1.0), 0, 0);
	var randAV = Vector3(0, 0, rand_range(-1.0, 1.0));
	
	set_linear_velocity(randLV);
	set_angular_velocity(randAV);
	
	set_fixed_process(true);

func _fixed_process(delta):
	var collider = get_colliding_bodies();
	if (collider.size() > 0):
		for i in collider:
			if (i extends StaticBody):
				queue_free();
				return;
			
			if (i extends preload("res://Scripts/Player/Controller.gd")):
				queue_free();
				return;
	
	if (get_global_transform().origin.y < -5.0):
		queue_free();
		return;
