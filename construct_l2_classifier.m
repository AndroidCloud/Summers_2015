function [tot_training_Set, tot_training_label] = construct_l2_classifier(class_map, word, Type, top_k, word_index_in_file)
	%% Type - Subject/Verb/Object
	percentage_of_frames = 100;
	number_training = 0;
	number_testing = 0;
	[answer,video] = find_word_video(class_map,word);
	for i = 1:size(video,2)
		if video(i) <= 1299
			number_training = number_training + 1;
		end
	end
	number_testing = size(video,2)  - number_training;
	training_set_positive = zeros(number_training, 3*top_k*1000);
	count_samples = 1;
	for i = 1:size(video,2)
                if video(i) <= 1299
			 try			  
			  training_set_positive(count_samples,:) = get_level2_feature(video(i), word, Type, top_k, word_index_in_file); 
			  count_samples = count_samples + 1;
			catch
				'Missing descriptor for word in video i in positive set'
			end
		end	
	end
	number_neg_training = 1 * (count_samples-1);
	training_set_positive = training_set_positive(1:count_samples-1, 1:3*top_k*1000);

	training_set_negative = zeros(number_neg_training, 3*top_k*1000);
        trinaing_label_negative = [];
        tot_set = zeros(1299,1);
        for i = 1:1299
                tot_set(i) = i;
        end
        missing_set = [142, 222,292,746,1002,1045,1066,1150,1189,1246,1261,1334,1355];
        new_Set = setdiff(tot_set, missing_set);
        neg_set = setdiff(new_Set, video(1:number_training));
        num_neg = size(neg_set,1);
        number_neg_training = min(number_neg_training, num_neg);
        p = randperm(num_neg,number_neg_training);
	negative_samples = neg_set(p(:));
        training_set_negative = zeros(number_neg_training, 3*top_k*1000);
        trining_label_negative = [] ;
        count_neg = 1;
        for j = 1:number_neg_training
                try
			training_set_negative(count_neg,:) = get_level2_feature(negative_samples(j), word, Type, top_k,word_index_in_file);
                        training_label_negative(count_neg) = 0;
                        count_neg = count_neg +1;
                catch
			'Missing descriptor for word in video i in negative set'
                end
        end
	count_pos = count_samples;
	tot_training_Set = zeros(count_pos -1 + number_neg_training , 3*top_k*1000);
        tot_training_label = zeros(1,count_pos - 1 + number_neg_training);
        for j = 1:count_pos-1
                tot_training_Set(j,:) = training_set_positive(j,:);
                tot_training_label(j) = 1;
        end
        for j = 1:count_neg-1
                tot_training_Set(count_pos -1  + j,:) = training_set_negative(j,:);
                tot_training_label(count_pos - 1 + j) = training_label_negative(j);
        end
end


