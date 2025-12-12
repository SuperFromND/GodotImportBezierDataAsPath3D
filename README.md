# Import Bezier Data As Path3D
This is a utility I wrote for [Godot](https://godotengine.org/) v4.4.1 that can import Bezier curve data exported from [Blender](https://www.blender.org/) v4.2.3 LTS using a custom import/export script. I created it due to the rather odd quirk that neither Godot nor the GLTF format it prefers supports curve import/export (as of this writing, December 2025), which is a critical component of a project I wanted to create.

# How to use
The basic idea is that we use Blender's scripting capabilities to print out all the points of a given Bezier curve, and then use a Godot plugin to reconstruct those points back into the original curve. This works out, since both programs support Bezier curves with [near-identical](https://docs.blender.org/api/current/bpy.types.BezierSplinePoint.html#bpy.types.BezierSplinePoint) [properties](https://docs.godotengine.org/en/stable/classes/class_curve3d.html#class-curve3d).

## Blender
The file `bezier_curve_export.py` is a [Blender Python](https://docs.blender.org/api/current/index.html) script. To use it:
- Load your Blender scene.
- Navigate to the Scripting workspace. If you don't have one, either [click the + at the very top of Blender's workspace tabs and add it](https://docs.blender.org/manual/en/latest/interface/window_system/workspaces.html), or set an area to the Text Editor (Shift+F11).
- Click "Open..." and load the script.
- Select a bezier curve object. Note that this script does not support other path objects such as NURBS or Paths.
- Open the Blender console. On Windows, you can go to **Window -> Toggle System Console**. On Linux and macOS, you may need to [run Blender from terminal instead.](https://docs.blender.org/manual/en/latest/advanced/command_line/)
- Click the Run Script button (the one with a play button).
The result should be a large block of text such as this appearing in your console. Copy it:
```
[[1.0, 0.0, 0.0, 0.8015028238296509, -0.09796421229839325, 0.0, 0.8015028238296509, 0.09796421229839325, 0.0, "VECTOR", "VECTOR", 0.0],
[0.404508501291275, 0.29389262199401855, 0.0, 0.6030056476593018, 0.1959284096956253, 0.0, 0.3726780116558075, 0.5129472613334656, 0.0, "VECTOR", "VECTOR", 0.0],
[0.30901700258255005, 0.9510565400123596, 0.0, 0.3408474922180176, 0.7320019006729126, 0.0, 0.15450850129127502, 0.7925471067428589, 0.0, "VECTOR", "VECTOR", 0.0],
[-0.15450850129127502, 0.4755282700061798, 0.0, 0.0, 0.6340377330780029, 0.0, -0.3726779818534851, 0.5129472613334656, 0.0, "VECTOR", "VECTOR", 0.0],
[-0.80901700258255, 0.5877852439880371, 0.0, -0.5908474922180176, 0.5503662824630737, 0.0, -0.7060113549232483, 0.3918568193912506, 0.0, "VECTOR", "VECTOR", 0.0],
[-0.5, 6.123234262925839e-17, 0.0, -0.6030056476593018, 0.1959284245967865, 0.0, -0.6030056476593018, -0.1959284245967865, 0.0, "VECTOR", "VECTOR", 0.0],
[-0.80901700258255, -0.5877852439880371, 0.0, -0.7060113549232483, -0.3918568193912506, 0.0, -0.5908474922180176, -0.5503662824630737, 0.0, "VECTOR", "VECTOR", 0.0],
[-0.15450850129127502, -0.4755282700061798, 0.0, -0.3726779818534851, -0.5129472613334656, 0.0, 0.0, -0.6340377330780029, 0.0, "VECTOR", "VECTOR", 0.0],
[0.30901700258255005, -0.9510565400123596, 0.0, 0.15450850129127502, -0.7925471067428589, 0.0, 0.3408474922180176, -0.7320019006729126, 0.0, "VECTOR", "VECTOR", 0.0],
[0.404508501291275, -0.29389262199401855, 0.0, 0.3726780116558075, -0.5129472613334656, 0.0, 0.6030056476593018, -0.1959284096956253, 0.0, "VECTOR", "VECTOR", 0.0]]
```

## Godot
The folder `importbezierdataaspath3d` is a [Godot plugin](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html).
- Put the folder in your `addons` folder in your project.
- Go to **Project -> Project Settings -> Plugins** and look for the newly-installed plugin. Click the checkbox to enable it.
- You should now see a new tab appear next to the File Inspector called "BezierImporter". Click it.
- Paste the text you got from Blender earlier into the text field, then click "OK".

You should now have a new Path3D in your scene tree! Using the above example, it should look like this:

<img width="1645" height="1014" alt="Godot screenshot." src="https://github.com/user-attachments/assets/42dba567-f4ba-40f1-8e87-2e721b93fd47" />


# Limitations
Currently this plugin ONLY supports Bezier curves. NURBS and Path objects in Blender are not supported and must be converted to Beziers first. Sorry!

# License
Both the Godot extension and my Blender script are released under The Unlicense; this effectively makes them public domain. Enjoy!

# Other resources
* [Blendot-Path-Tool](https://github.com/azimuthdeveloper/Blendot-Path-Tool): similar extension created by @azimuthdeveloper. Didn't work for me, but that's possibly due to its age.
* https://github.com/godotengine/godot/issues/76615: Issue on Godot's repository covering bezier curve importing
