function classifier_list = level_2_classifier(top_k,One,Two)
	 
     load('./file_names.mat');
     load('./folder_names.mat');
     if strcmp(One,'Subject') && strcmp(Two,'Subject')
	index_a = 1;
	index_b = 1;
     end
     if strcmp(One,'Subject') && strcmp(Two,'Verb')
	index_a = 1;
	index_b = 2;
     end
     if strcmp(One,'Subject') && strcmp(Two,'Object')
	index_a = 1;
	index_b = 3;
     end 
     if strcmp(One,'Verb') && strcmp(Two, 'Subject')
	index_a = 2;
	index_b = 1;
     end
     if strcmp(One,'Verb') && strcmp(Two, 'Verb')
	index_a = 2;
	index_b = 2;
     end
     if strcmp(One, 'Verb') && strcmp(Two, 'Object')
	index_a = 2;
	index_b = 3;
     end
     if strcmp(One, 'Object') && strcmp(Two, 'Subject')
	index_a = 3;
	index_b = 1;
     end
     if strcmp(One, 'Object') && strcmp(Two, 'Verb')
	index_a = 3;
	index_b = 2;
     end
     if strcmp(One,'Object') && strcmp(Two, 'Object')
	index_a = 3;
	index_b = 3;
     end
     [matrix] = compare_one_model_with_another(file_names{index_a},file_names{index_b},folder_names{index_a},folder_names{index_b});
     classifier_list = get_top_k_classifier(matrix, Two, top_k);
     %% model_K_40_verbs_top_10
     %% model_K_30_subjects_top_100
     %% model_K_40_objects_top_10
     %% 'youtube_setof_subjects.txt','youtube_setof_verbs.txt','youtube_setof_objects.txt'
%    find top k classifier for each of subject,object and verb
%    fit a svm for this descriptor 
%    save the model for that particular subject, verb, or object 
end


function word_list = get_word_list(index_list, file, top_k)
     fid  = fopen(strcat('youtube_setof_',lower(file),'s.txt'), 'r');
     word = textscan(fid,'%s');
     [scores, index_word] = sort(index_list);    
     word_list = {};
     total_length = size(index_word,2);
     count_track = 1;
     %for i = total_length - top_k + 1:total_length
     for i = 1:total_length
	 word_list{count_track} = word{1}{index_word(i)};
	 count_track = count_track + 1;
     end	
end


function word_tot_list = get_top_k_classifier(matrix, Type, top_k)
	total_number = size(matrix,1);
	word_tot_list = {};
	for i=1:total_number
		word_tot_list{i} = get_word_list(matrix(i,:), Type , top_k);
	end
end	
