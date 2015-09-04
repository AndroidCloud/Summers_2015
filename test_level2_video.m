function [maxi, index_max] = test_level2_video(class_map, word, video_index, type_level, model_path, Type_word, top_k, word_index_in_file)
	addpath('libsvm-3.18/matlab');
	if strcmp(type_level,'level2')
                fid1  = fopen('youtube_subjects_answers.txt', 'r');
                fid2  = fopen('youtube_objects_answers.txt', 'r');
                fid3  = fopen('youtube_verbs_answers.txt', 'r');
                word_subject = textscan(fid1,'%s %s');
                word_object = textscan(fid2,'%s %s');
                word_verb = textscan(fid3,'%s %s');
                ground_truth_subject = word_subject{2}{video_index-1300+1};
                ground_truth_verb = word_verb{2}{video_index -1300 +1};
                ground_truth_object = word_object{2}{video_index - 1300 +1};
               % classifier_list_subject = load_level_2_classifier(top_k, Type_word, 'Subject');
               % classifier_list_object = load_level_2_classifier(top_k, Type_word, 'Object');
               % classifier_list_Verb = load_level_2_classifier(top_k, Type_word, 'Verb');
                classifier_list_subject = load_level_2_classifier(top_k, 'Subject', 'Subject');
                classifier_list_object = load_level_2_classifier(top_k, 'Object', 'Object');
                classifier_list_Verb = load_level_2_classifier(top_k, 'Verb', 'Verb');
                descriptor=get_l2_descriptor(classifier_list_subject,classifier_list_object,classifier_list_Verb,ground_truth_subject,ground_truth_verb,ground_truth_object,top_k);
		load(fullfile(model_path, strcat(word,'_model.mat')));
                word
		testing_set = zeros(1, 3*top_k*1000);
                testing_set(1,:) = descriptor;
                testing_set_label = 0;
                count_samples = 1;
		[predicted_label, accuracy, decision_values] = svmpredict(testing_set_label, testing_set, model,'-b 1');
		%decision_values(1), decision_values(2)
		index_max = 0;
		maxi = 0;
		if decision_values(1) >= decision_values(2)
			index_max = 1;
			maxi = decision_values(1);
		end
		if decision_values(1) < decision_values(2)
			index_max = 2;
			maxi = decision_values(2);
		end
                return_value = [maxi, index_max];
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
                                    
