function run_level2_classifier(class_map, top_k, file, Type) 
	%% file - youtube_setof_{subjects/objects/verbs}.txt
	%% Type - Subject/Verb/Object
	fid1  = fopen(file, 'r');
	word_type = textscan(fid1,'%s');
        for i=1:size(word_type{1},1)
		if exist(fullfile('l2_model',strcat('top_k_',num2str(top_k)),Type, strcat(word_type{1}{i},'_model.mat'))) == 0
			classify_level2_model(class_map, word_type{1}{i}, Type, top_k, i);
		end
	end
	fclose(fid1);
end 
