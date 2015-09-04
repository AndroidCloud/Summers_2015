function [number_training, number_testing, accur] = test(C, word, percentage_of_frames, number_neg_training,a)
        
	[tot_training_Set,tot_training_label,training_set_positive,number_training]=find_feature_vector_for_class(C,word,percentage_of_frames,number_neg_training,a);
	'training begin'
	addpath('libsvm-3.18/matlab');
	model = svmtrain(tot_training_label',tot_training_Set);
	[predicted_label, accuracy, number_testing]= test_classifier(model,C,word, percentage_of_frames,a);
	accur = accuracy;
end
