function return_value = run_test_each_video(file_to_write, file_to_open, class_map, type, model_path, Type_word, top_k)
	fileID = fopen(file_to_write,'w');
	if strcmp(type,'level1')
		fid = fopen(file_to_open,'r');
		w = textscan(fid,'%s');
		for i=1300:1970
			try
			return_value=zeros(size(w{1},1),1);
			for j = 1:size(w{1},1)
				return_value(j) = test_each_video(class_map, w{1}{j}, i, type, model_path);
			end
			catch
				i	
			end
			[score, word_index] = max(return_value);
			fprintf(fileID,'%d %s\n',i,w{1}{word_index});
		end
		fclose(fid);
		fclose(fileID);
	end
	if strcmp(type,'level2')
		fid = fopen(strcat('youtube_setof_',file_to_open,'.txt'),'r');
                w = textscan(fid,'%s');
		fid2 = fopen(strcat('youtube_',file_to_open,'_answers.txt'),'r');
		w2 = textscan(fid2,'%s %s');
		for i=1300:1970
			try
				return_value=zeros(size(w{1},1),1);
				return_indices_value = zeros(size(w{1},1),1);
				for j = 1:size(w{1},1)
				    [return_value(j),return_indices_value(j)] = test_level2_video(class_map, w{1}{j}, i, type, model_path, Type_word, top_k, j);
				end
			catch
				i	
			end
			[score, word_index] = max(return_value);
			fprintf(fileID,'%d %s %s\n',i,w2{2}{i-1300+1}, w{1}{word_index});
		 %       [return_value,return_indices_value]
		 %	word_index
		%	input('y');
		end
		fclose(fid);
		fclose(fid2);
		fclose(fileID);
	end
	
end
