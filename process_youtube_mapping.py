mapping = {};
lines = [line.rstrip('\r\n') for line in open('youtube_mapping.txt')]
for i in range(len(lines)):
	video_des = str.split(lines[i],' ');
	mapping[video_des[0]] = video_des[1]

print mapping
