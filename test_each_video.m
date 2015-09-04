function return_value = test_each_video(class_map, word, video_index, type_level, model_path)
	addpath('libsvm-3.18/matlab');
	if strcmp(type_level,'level1')
		[answer,video] = find_word_video(class_map, word);
		testing_set = zeros(1, 1000);
		load(fullfile('./frame_features/',strcat('features_vid',num2str(video_index),'.mat')));
	       	testing_set(1,:) = get_feature_vector(vector_video, 4,100, 100,0);
		testing_set_label = zeros(1, 1);
       		count_samples = 1;
	        if (sum(ismember(video,video_index)) == 1)
        	        testing_set_label(count_samples) = 1;
	        else    
        	       	testing_set_label(count_samples) = 0;
	        end
		load(fullfile(model_path, strcat(word,'_model.mat'))); 
	        [predicted_label, accuracy, decision_values] = svmpredict(testing_set_label, testing_set, model,'-b 1');
		decision_values(1);
		return_value = decision_values(1);
	end
	if strcmp(type_level,'level2)
		fid1  = fopen('youtube_subject_answers.txt', 'r');
	        fid2  = fopen('youtube_object_answers.txt', 'r');
	        fid3  = fopen('youtube_verb_answers.txt', 'r');
	        word_subject = textscan(fid1,'%s');
	        word_object = textscan(fid2,'%s');
	        word_verb = textscan(fid3,'%s');
	        ground_truth_subject = word_subject{1}(video_index-1300+1);  
	        ground_truth_verb = word_verb{1}(video_index -1300 +1);
	        ground_truth_object = word_object{1}(video_index - 1300 +1);    
	
		classifier_list_subject = load_level_2_classifier(top_k, Type_word, 'Subject');    
	        classifier_list_object = load_level_2_classifier(top_k, Type_word, 'Object');    
        	classifier_list_Verb = load_level_2_classifier(top_k, Type_word, 'Verb');    
	        descriptor= get_l2_descriptor(classifier_list_subject,classifier_list_object, classifier_list_Verb, word_index_in_file, top_k); 	       load(fullfile(model_path, strcat(word,'_model.mat')));	      
                fclose(fid1);
                fclose(fid2);
                fclose(fid3);
	
	end
end
      
function classifier_list = load_level_2_classifier(top_k, TypeA, TypeB)

        var_name = strcat('classifier_list_',lower(TypeA),'_',lower(TypeB));
        a = load(fullfile('matrixes',strcat(var_name,'.mat')));
        list = a.(var_name);
        classifier_list = {};
        for i=1:size(list,2)
                classifier_list{i} = list{i}(end-top_k+1:end);
        end
end 
