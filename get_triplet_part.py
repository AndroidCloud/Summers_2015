from itertools import groupby;
from collections import OrderedDict;
def get_mapping(Type):
        map_videos = {};
        lines = [line.rstrip('\r\n') for line in open('youtube_' + Type +  '.txt')];
	for i in range(len(lines)):
        	dic = OrderedDict();
		text = lines[i].split()[1];
		list_triplet = [''.join(g) for _, g in groupby(text, str.isalpha)];
		j=0;
		while j < len(list_triplet):
			dic[list_triplet[j]] = 1;
			j = j+2;		
		map_videos['vid' + `i+1`] = dic;
	
	return map_videos;
