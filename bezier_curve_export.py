# Bezier curve point exporter for Blender 4.2.3 LTS (2025 SuperFromND; CC0/Unlicense; use for whatever!)
# Select a curve object (expects BezierCurve only, no NURBS or Blender Path; convert those to beziers before using!)
import bpy
import json

obj = bpy.context.object
print("obj:", bpy.context.object.name)

# stores all points and handle data
d = []

for s in obj.data.splines:
    for p in s.bezier_points:
        c = p.co
        l = p.handle_left
        r = p.handle_right
        lt = p.handle_left_type
        rt = p.handle_right_type
        
        print("point", p.co)
        print("left handle:", lt, l)
        print("right handle:", rt, r)
        print("tilt:", p.tilt)
        d.append([c[0], c[1], c[2], l[0], l[1], l[2], r[0], r[1], r[2], lt, rt, p.tilt])

# prints result to the console (Window -> Toggle System Console)
print("\n")

# weird syntax but basically just makes strings "like this" instead of 'this'
# godot's str_to_var function doesnt like single quoted strings
# also adds line breaks for easier reading
print(str(d).replace("'", "\"").replace("], ", "],\n"))