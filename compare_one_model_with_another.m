function [matrix] = compare_one_model_with_another(file1,file2, model_folder1, model_folder2)

	 fid1 = fopen(file1,'r');
         word1 = textscan(fid1,'%s');
	 fid2 = fopen(file2,'r');
         word2 = textscan(fid2,'%s');
	 matrix = zeros(size(word1{1},1),size(word2{1},1));
	 for j = 1:size(word1{1},1)
		if strcmp(word1{1}{j},'peeler') == 0 
			load(fullfile('./model',model_folder1,strcat(word1{1}{j},'_model.mat')));
	   		vector1 = (model.sv_coef' * full(model.SVs));
	    		for i = 1:size(word2{1},1)	
	    			if strcmp(word2{1}{i},'peeler') == 0
					load(fullfile('./model',model_folder2,strcat(word2{1}{i},'_model.mat')));
	    				vector2 = (model.sv_coef' * full(model.SVs));
					matrix(j,i) = similarity_score(vector1, vector2);
				else
					matrix(j,i) = 0;
				end
	    		end
	 	end
	end
end

function similarity = similarity_score(vec1, vec2)

	similarity = ((mean(vec1) - mean(vec2))^2)/(var(vec1) + var(vec2));

end
