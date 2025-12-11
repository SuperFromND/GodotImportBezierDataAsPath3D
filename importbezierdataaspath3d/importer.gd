@tool
extends Control

func _enter_tree():
	$ok.pressed.connect(clicked)

func clicked():
	var text = $text.text
	if (text.is_empty()):
		print("No text could be found.")
		pass
	else:
		var parsed = str_to_var(text)
		var length = len(parsed)
		
		if parsed == null:
			print("Couldn't parse text.")
			pass
		
		# if we made it here then we know we have valid data (maybe)
		# let's make our object :]
		print("Creating path object...")
		var path_object = Path3D.new()
		var curve = Curve3D.new()
		
		for n in length:
			print("Adding node #", n, "...")
			
			# since we made the exporter, we can expect a specific order in each array entry
			# so in this case its okay to just hardcode our array indexes
			# (ideally id put them in keys anyways but this has taken long enough to do as is)\
			var start = Vector3(-parsed[n][0], parsed[n][2], parsed[n][1])
			var in_p = Vector3(-parsed[n][3], parsed[n][5], parsed[n][4])
			var out_p = Vector3(-parsed[n][6], parsed[n][8], parsed[n][7])
			
			curve.add_point(start, start - in_p, start - out_p)
		
		print("Applying curve...")
		path_object.set_curve(curve)
		
		print("Adding path to scene...")
		var scene_root = EditorInterface.get_edited_scene_root()
		scene_root.add_child(path_object)
		path_object.set_owner(scene_root)
		
		print("Done!")
