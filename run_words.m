function run_words(file1,file2,class_map,number_of_frames,number_negative_samples,a,percentage)
	addpath('./libsvm-3.18/matlab/');
	fid = fopen(file1,'r');
	fileID = fopen(strcat(file2,'_','percentageframes',num2str(number_of_frames),'_feature',num2str(a),'.txt'),'w');
        w = textscan(fid,'%s');
	tot = 0;
	count = 0;
	count_nan = 0;
	for i = 1:size(w{1},1)
		try
			[predicted_label , testing_label, decision_values, precision, recall, f_measure] =  classify_model(class_map, w{1}{i}, number_of_frames, number_negative_samples, a, percentage);
			if isnan(f_measure) == 1
				count_nan = count_nan + 1;
			end
			if isnan(f_measure) ~= 1
				fprintf(fileID,'%s  %d %d %f\n',w{1}{i}, sum(predicted_label),sum(testing_label), f_measure);
				f_measure, sum(predicted_label)
				tot = tot + 1;
				w{1}{i}
				count = count + f_measure;
			end
		catch

		end
	end
	tot
	count
	count_nan
	fclose(fileID);
	fclose(fid);
	
end
