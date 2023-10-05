extends Area2D
@export var type = "camera"
var rng = RandomNumberGenerator.new()
@onready var camera := $Camera2D
var default_offset:Vector2
var cam_zoomer:Tween
var default_camera_zoom:Vector2

func _ready():
	default_offset = camera.offset
	default_camera_zoom = camera.zoom
func _process(delta):
	if stateMachine.current_hero != 0:
		self.position = stateMachine.camera_target.position

func _physics_process(delta):
	if get_tree().paused and stateMachine.cloneBarReverse != null and stateMachine.cloneBarReverse.is_running():
		camera.offset = Vector2(rng.randf_range(5, -5), rng.randf_range(5, -5))
		if cam_zoomer == null:
			cam_zoomer = create_tween()
			cam_zoomer.tween_property(camera, "zoom", Vector2(1.8, 1.8), 1)
			cam_zoomer.tween_callback(func(): cam_zoomer = null)
	else:
		camera.offset = default_offset
		camera.zoom = default_camera_zoom

