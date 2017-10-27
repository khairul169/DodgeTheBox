extends Camera

# Exports
export(NodePath) var PlayerNode;
export(float) var CameraInterpolation = 5.0;

# Variables
var CamY = 0.0;
var TargetCamY = 0.0;
var Interpolation = 0.0;

func _ready():
	# Init
	PlayerNode = get_node(PlayerNode);
	TargetCamY = get_global_transform().origin.y;
	
	# Set Y Pos
	var Pos = get_translation();
	Pos.y = 10.0;
	set_translation(Pos);
	
	set_process(true);

func _process(delta):
	Interpolation = min(Interpolation + 2 * delta, CameraInterpolation);
	
	var transform = get_global_transform();
	var targetPos = transform.origin;
	targetPos.x = PlayerNode.get_global_transform().origin.x;
	targetPos.y = TargetCamY;
	transform.origin = transform.origin.linear_interpolate(targetPos, Interpolation * delta);
	set_global_transform(transform);
	
	var playerDir = PlayerNode.dir;
	var targetRotation = get_rotation_deg();
	targetRotation.z = lerp(targetRotation.z, 5 * playerDir.x, Interpolation * delta);
	set_rotation_deg(targetRotation);
