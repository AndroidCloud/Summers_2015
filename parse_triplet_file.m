function C = parse_triplet_file(filename)
	
	fid = fopen('youtube_triplets.txt','r');
	w = textscan(fid,'%s');
	C = containers.Map;
	i = 2;
	while i <= size(w{1},1)		
		video_number = i/2;
		F={};
		D = strsplit(w{1}{i},'|');
		for j = 1:size(D,2)
			if j ~= size(D,2)
				E = strsplit(D{j},{',',':'});
				E = E(1:3);
				F{j} = E;
			end
			%input('y');
		end
		C(num2str(video_number)) = F;	
		i=i+2;	
	end
end
