function [predicted_label, accuracy, decision_values, testing_set_label] = test_classifier(model,class_map,word, percentage_of_frames,a, percentage)
	percentage_of_frames
	percentage
	[answer,video] = find_word_video(class_map,word);
	testing_set = zeros(1970-1300+1, 1000);
        testing_set_label = zeros(1970 - 1300 + 1, 1);
	count_samples = 1;
        for i = 1300:1970
             try
                if (sum(ismember(video,i)) == 1)
			testing_set_label(count_samples) = 1;
		else	
			testing_set_label(count_samples) = 0;
		end
                load(fullfile('./frame_features/',strcat('features_vid',num2str(i),'.mat')));
                testing_set(count_samples,:) = get_feature_vector(vector_video, 4, percentage_of_frames, percentage,0);
                count_samples = count_samples + 1;
             catch
                'Something is missing in test_classifier'
             end
        end
	testing_set = testing_set(1:count_samples-1,1:1000);
        testing_set_label = testing_set_label(1:count_samples-1,1);
        count_samples	
	
        addpath('libsvm-3.18/matlab');
        testing_set_label;
	size(testing_set_label')
	size(testing_set)
        %count
        [predicted_label, accuracy, decision_values] = svmpredict(testing_set_label, testing_set, model,'-b 1');
	predicted_label;

end
