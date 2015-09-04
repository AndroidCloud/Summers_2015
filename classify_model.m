function [predicted_label , testing_label, decision_values, precision, recall, max_measure] =  classify_model(class_map, word, percentage_of_frames, number_neg_training, a, percentage) 
	
	[tot_training_Set,tot_training_label,training_set_positive,number_training] = find_feature_vector_for_class(class_map,word,percentage_of_frames, number_neg_training, a ,percentage);
	
	number_training
	size(training_set_positive)
	size(tot_training_label)
	size(tot_training_Set)
	model = svmtrain(tot_training_label',tot_training_Set,'-b 1');
%%	save(fullfile('model','model_K_40_objects_top_10',strcat(word,'_','model.mat')),'model');        
	word  
       [predicted_label, accuracy,decision_values,testing_label]=test_classifier(model,class_map,word, percentage_of_frames,a,percentage);
	max_measure = 0;
	threshold = 0.05;
%	max_measure = 0;
	while threshold <= 0.95	
        	converted_vector = convert_decisionProb_percentage(decision_values, threshold);
		[precision, recall, f_measure]  = Evaluate(testing_label, converted_vector);
%		sum(converted_vector)
%		sum(testing_label)
%		f_measure
		if isnan(f_measure) ~= 1 
			if f_measure > max_measure
				max_measure = f_measure;	
			end
		end
		threshold = threshold + 0.05;
%		input('y');
	end		
	%precision, recall
end
