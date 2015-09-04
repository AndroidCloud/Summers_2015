from get_triplet_part import get_mapping
def write_type_to_file(Type):
	we = get_mapping(Type);
	file = open(Type + '.txt','w');
	for i in range(1970):
		keys = we['vid' + `i+1`].keys();
		file.write(keys[0]);
		file.write('\n');
	
	file.close()
