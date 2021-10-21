extends Node2D

# File to test GDScript sintax

var nums = [2,3,4,1,5,2]

var imagesPath = "res://assets/images/planets"

# Return an array with images file names from a folder
func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			if not file.ends_with('import'):
				files.append(file)

	dir.list_dir_end()

	return files

func _ready():
	print(nums)
	# Delete firs element if exists
	# print(nums.pop_front())
	
	# Delete an element of a position, returng Null
	print(nums.remove(1))
	
	print(nums)
