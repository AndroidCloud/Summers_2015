def dictionary(Type):
	map_videos = {};
	for i in range(1970):
		dic = {};
		lines = [line.rstrip('\r\n') for line in open('./SVO_Triplets/' + 'vid' + `i+1` + '.txt')];
		for j in range(len(lines)):
			a=lines[j].split();
			if len(a) > 0:
				if a[0]==Type:
					if dic.has_key(a[2]):
						dic[a[2]] = dic[a[2]] + 1;
					else:
						dic[a[2]] = 1;
			if len(a) > 3:
				if a[3]==Type:
					if dic.has_key(a[5]):
						dic[a[5]] = dic[a[5]] + 1;
					else:
						dic[a[5]] = 1;
			if len(a) > 6:
				if a[6]==Type:
					if dic.has_key(a[8]):
						dic[a[8]] = dic[a[8]] + 1;
					else:
						dic[a[8]] = 1;
		map_videos['vid' + `i+1`] = dic;
	return map_videos;

					
					
	
	
