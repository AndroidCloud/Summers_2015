function [answer,video] = find_word_video(class_map,word)
	
	answer = zeros(3,1);
	video = [];
	count = 1;
	for video_index = 1:size(class_map,1)
		video_des = class_map(num2str(video_index));
		flag = 0;
		for des = 1:size(video_des,2)
			second_flag = 0;
			if strcmp(video_des{des}{1},word) == 1
				second_flag = 1;
				answer(1) = answer(1) + 1;
			end
			if strcmp(video_des{des}{2},word) == 1
				answer(2) = answer(2) + 1;
				second_flag = 1;
			end
			if strcmp(video_des{des}{3},word) == 1
				answer(3) = answer(3) + 1;
				second_flag = 1;
			end
			if flag == 0
				if second_flag == 1
					video(count) = video_index;
					count = count + 1;
					flag = 1;
				end
			end
		end
	end
		
end	

