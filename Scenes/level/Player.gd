extends CharacterBody3D


const SPEED = 8.0

var object: Node
var objects: Array=[]

#
#var contact:String = ""
#var face:CompressedTexture2D
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Action"):
		action()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Up", "Down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	#quand on se déplace 
	#check si ca vaut le coup
	#de savoir avec quoi on va interargir 
	if len(objects)>0:
		who_is_closest()
	move_and_slide()

func action()->void:
	if object != null:
		object.interact()
		

## PROXIMITY HANDELING

func who_is_closest():
	var closest_object: Node3D = null
	var closest_distance = INF
	for i in objects:
		var distance = global_transform.origin.distance_to(i.global_transform.origin)
		if distance < closest_distance:
			closest_distance = distance
			closest_object = i
	if(object!=closest_object):
		object=closest_object
		closest_changed()
	else:
		object=closest_object
	return closest_object

func closest_changed():
	print("hey ca a changé")
	for i in objects:
		if i==object:
			i.talkable(true)
		else:
			i.talkable(false)

func add_contact(collider)->void:
	print("add contact")
	objects.append(collider)
	print(objects)

func loose_contact(collider)->void:
	print("loose_contact")
	objects.erase(collider)
	collider.talkable(false)
