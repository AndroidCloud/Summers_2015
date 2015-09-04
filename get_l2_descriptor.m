function descriptor = get_l2_descriptor(classifier_list_subject, classifier_list_object,classifier_list_Verb, subject, verb, object, top_k)

	folder_subject = 'model/model_K_30_subjects_top_100'; 
	folder_object = 'model/model_K_40_objects_top_10';
	folder_verb = 'model/model_K_40_verbs_top_10';	
	descriptor = []; 
	
	for i=1:top_k
		load(fullfile(folder_subject, strcat(classifier_list_subject{get_subject(subject)}{i},'_model.mat')));
		w = (model.sv_coef' * full(model.SVs));
		descriptor = [descriptor, w];
	end
	for i=1:top_k
		load(fullfile(folder_verb, strcat(classifier_list_Verb{get_verb(verb)}{i},'_model.mat')));
		w = (model.sv_coef' * full(model.SVs));
		descriptor = [descriptor, w];
	end
	for i=1:top_k
		load(fullfile(folder_object, strcat(classifier_list_object{get_object(object)}{i},'_model.mat')));
		w = (model.sv_coef' * full(model.SVs));
		descriptor = [descriptor, w];
	end
	

end


function index = get_subject(subject)
	fid1  = fopen('youtube_setof_subjects.txt', 'r');
	w = textscan(fid1, '%s');
        index = find(ismember(w{1}, subject));
	fclose(fid1);
end
function index = get_verb(verb)
	fid1  = fopen('youtube_setof_verbs.txt', 'r');
	w = textscan(fid1, '%s');
        index = find(ismember(w{1}, verb));
	fclose(fid1);
end
function index = get_object(object)
	fid1  = fopen('youtube_setof_objects.txt', 'r');
	w = textscan(fid1, '%s');
        index = find(ismember(w{1}, object));
	fclose(fid1);
end
