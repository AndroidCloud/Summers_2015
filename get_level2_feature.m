function descriptor = get_level2_feature(video_index, word, Type, top_k, word_index_in_file)
	%% word- word for which we are constructing a level 2 classifier.
	%% video_index - index of video in which that 'word' is present.
	%% Type - Is the word classified as subject, verb, object
	%% word_index_in_file - index of the word 'word' in youtube_set_of_{subjects/objects/verbs}.txt
	%% training time 
	%% see which of the following Subject/verb/Object/ is  occuring most of the time .
	%% now corresponding to each S/V/O find the descriptor
	fid1  = fopen('subjects.txt', 'r');
	fid2  = fopen('objects.txt', 'r');
	fid3  = fopen('verbs.txt', 'r');
	word_subject = textscan(fid1,'%s');
	word_object = textscan(fid2,'%s');
	word_verb = textscan(fid3,'%s');
	ground_truth_subject = word_subject{1}(video_index);  
	ground_truth_verb = word_verb{1}(video_index);
	ground_truth_object = word_object{1}(video_index);	
	
%	classifier_list_subject = load_level_2_classifier(top_k, Type, 'Subject');	
%	classifier_list_object = load_level_2_classifier(top_k, Type, 'Object');	
%	classifier_list_Verb = load_level_2_classifier(top_k, Type, 'Verb');	
	classifier_list_subject = load_level_2_classifier(top_k, 'Subject', 'Subject');	
	classifier_list_object = load_level_2_classifier(top_k, 'Object', 'Object');	
	classifier_list_Verb = load_level_2_classifier(top_k, 'Verb', 'Verb');	
	
	descriptor = get_l2_descriptor(classifier_list_subject, classifier_list_object, classifier_list_Verb, ground_truth_subject, ground_truth_verb, ground_truth_object, top_k);	
  	fclose(fid1);
	fclose(fid2);
	fclose(fid3);	
	%% testing time
	%% Read the predictions by our first level classifiers.
	%% Load the top k classifier corresponding to each of S/V/O  


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
