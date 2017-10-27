extends RigidBody

# Consts
const SPEED = 8.0;

# Nodes
var BodyNode;
var AnimationNode;
var ParticleNode;

# Variables
var dir = Vector3();
var curAnim = "";

func _ready():
	# Register node
	GameManager.PlayerNode = self;
	
	# Init nodes
	BodyNode = get_node("Body");
	AnimationNode = BodyNode.find_node("AnimationPlayer");
	AnimationNode.set_default_blend_time(0.1);
	ParticleNode = get_node("Particles");
	
	# Enable fixed process
	set_fixed_process(true);

func _fixed_process(delta):
	check_movement(delta);
	check_rotation(delta);
	check_animation();

func check_movement(delta):
	if (GameManager.GameState != GameManager.GameStates.Playing):
		return;
	
	var pos = get_global_transform().origin;
	dir = Vector3();
	
	if (GameManager.IsMobile):
		if (GameManager.ControllerType == GameManager.Controller.Touch):
			if (GameManager.TouchControl.is_pressed[0]):
				dir.x -= 1.0;
			if (GameManager.TouchControl.is_pressed[1]):
				dir.x += 1.0;
		
		if (GameManager.ControllerType == GameManager.Controller.DeviceTilt):
			var accelSensor = Input.get_accelerometer();
			if (accelSensor.x > 1.0):
				dir.x -= 1.0;
			if (accelSensor.x < -1.0):
				dir.x += 1.0;
	
	else:
		if (Input.is_key_pressed(KEY_A)):
			dir.x -= 1.0;
		if (Input.is_key_pressed(KEY_D)):
			dir.x += 1.0;
	
	var lv = get_linear_velocity();
	var motion = dir.normalized() * SPEED;
	lv.x = lerp(lv.x, motion.x, 8 * delta);
	
	if (pos.y < -5.0):
		set_translation(Vector3(0, 0.5, 0));
		lv *= 0.0;
	
	if (abs(lv.x) > 0.1):
		if (!ParticleNode.is_emitting()):
			ParticleNode.set_emitting(true);
	else:
		if (ParticleNode.is_emitting()):
			ParticleNode.set_emitting(false);
	
	set_linear_velocity(lv);

func check_rotation(delta):
	var bodyRotation = 0.0;
	if (dir.x < 0.0):
		bodyRotation -= 90.0;
	if (dir.x > 0.0):
		bodyRotation += 90.0;
	
	var targetRotation = BodyNode.get_rotation_deg();
	targetRotation.y = lerp(targetRotation.y, bodyRotation, 10 * delta);
	BodyNode.set_rotation_deg(targetRotation);

func check_animation():
	var targetAnim = "idle";
	if (abs(dir.x) > 0.0):
		targetAnim = "run";
	
	if (curAnim != targetAnim):
		curAnim = targetAnim;
		
		AnimationNode.get_animation(targetAnim).set_loop(true);
		AnimationNode.play(targetAnim);
