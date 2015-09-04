from process_svo_triplets_file import dictionary; 
from wnsimilarity import getSenseSimilarity;
from get_triplet_part import get_mapping;

def get_highest_frequency(map_videos,key_value):
	all_keys = map_videos[key_value].keys();
	highest_word = all_keys[0]
	highest_frequency = map_videos[key_value][highest_word];
	for i in range(len(all_keys)):
		if map_videos[key_value][all_keys[i]] > highest_frequency:
			highest_frequency =  map_videos[key_value][all_keys[i]];
			highest_word = all_keys[i];
		
	return highest_word;

def get_highest_wup(map_videos,video_index, key_word):
	all_keys = map_videos[video_index].keys();
	highest_wup = 0;
	for i in range(len(all_keys)):
		wup = getSenseSimilarity(key_word,all_keys[i]);  
		if wup > highest_wup:
			highest_wup = wup;
	return highest_wup;


def get_most_occuring_wup(map_videos,video_index, key_word):
	all_keys = map_videos[video_index].keys();
	wup = getSenseSimilarity(key_word,all_keys[0]);  
	return wup;


def compare(file1,Type,file_write):
	 count = 0;
	 count_two = 0;
	 #map_videos = dictionary(Type);
	 map_videos = get_mapping(Type);
	 target = open(file_write, 'a');
	 lines = [line.rstrip('\r\n') for line in open(file1)];
	 tot = len(lines);
	 for i in range(len(lines)):
		a = lines[i].split();
		index = a[0];
		if map_videos['vid' + index].has_key(a[1]):
			count =  count + 1;
		highest_frequency_word = get_highest_frequency(map_videos,'vid' + index);
		if a[1] == highest_frequency_word:
			 count_two = count_two + 1;
		target.write(index);	
		target.write("  ");
		target.write(a[1]);	
		target.write("  ");
		target.write(highest_frequency_word);
		target.write("\n");
	 print count_two;
	 target.close();
	 return count; 
		
def get_wup(file1,Type, flag):
	 count = 0;
	 #map_videos = dictionary(Type);
	 map_videos = get_mapping(Type);
	 lines = [line.rstrip('\r\n') for line in open(file1)];
	 tot = len(lines);
	 for i in range(len(lines)):
		a = lines[i].split();
		index = a[0];
		highest_frequency_wup = 0;
		if flag == 1:
			highest_frequency_wup = get_highest_wup(map_videos,'vid' + index,a[1]);
		elif flag == 0:
			 highest_frequency_wup = get_most_occuring_wup(map_videos,'vid' + index,a[1]);
		count = count + highest_frequency_wup;
	 return count; 
