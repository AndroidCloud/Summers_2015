function  classify_level2_model(class_map, word, Type, top_k, word_index_in_file)
 
	[tot_training_Set, tot_training_label] = construct_l2_classifier(class_map, word, Type, top_k, word_index_in_file);
	addpath('libsvm-3.18/matlab');
	model = svmtrain(tot_training_label',tot_training_Set,'-b 1');
	save(fullfile('l2_model',strcat('top_k_',num2str(top_k)),Type, strcat(word,'_model.mat')),'model');

%%	save(fullfile('model','model_K_40_objects_top_10',strcat(word,'_','model.mat')),'model');        
	word  
end
