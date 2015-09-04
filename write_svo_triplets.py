if __name__=="__main__":
	lines = [line.rstrip('\r\n') for line in open('descriptions.csv')];
	for i in range(len(lines)):
		try:
			w=str.split(lines[i],'||')
	 		video_name = mapping[w[0]+'_'+w[1]+'_'+w[2]]
	 		target = open('./Videos/'+video_name + '.txt', 'a');
			target.write(w[3]);
			target.write('\n');
		except:
			print w
		
