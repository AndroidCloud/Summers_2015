function feature_vector = get_feature_vector(class_vector, a , percentage_of_frame, percentage,flag)


	if (flag)
		'I am here'
		vector_video = class_vector;
		S = std(vector_video);
       		[A,B] = sort(S);
        	index = B(1000);
        	W=vector_video(:,index);
        	[v,m]=sort(W);
 	        num_frames = floor(((percentage)*size(m,1))/100);
        	start_index =  size(m,1) - num_frames + 1;
        	end_index = size(m,1);
        	vec_video = zeros(num_frames,1000);
        	count = 1;
        	for i = start_index:end_index
                	vec_video(count,:)= vector_video(m(i),:);
                	count = count + 1;
        	end
		class_vector = vec_video;
	end
	vector = zeros(size(class_vector,1),size(class_vector,2));
	number_of_frames = size(class_vector,1);
	number_of_frames = floor((percentage_of_frame * number_of_frames)/100);
	if a == 3
		for i = 1 : number_of_frames
			[bestScore, best] = sort(class_vector(i,:));
			feat = zeros(size(class_vector,2),1);
			for j=991:1000
				feat(best(j)) = 1;
			end
			vector(i,:)= feat;
		end
		feature_vector = mean(vector);
	end
	if a == 1
		feature_vector = max( class_vector, [], 1 ); 
	end
	if a == 2
		feature_vector = mean(class_vector);
	end 

%	a. take top 20 from each frame
%	b. average over all frames
%	c. keep the top 20 with highest average
%	d. now select top-k frames for the average value of the selected top 20 features
%   		top k_frames and top k_features
%	e. average value of top k_features for the top k_frames
	
	if a == 4
		k_features = 40;
		k_frames = 40;
		for i = 1 : number_of_frames
			[bestScore, best] = sort(class_vector(i,:));
			feat = zeros(size(class_vector,2),1);
			for j=991:1000
				feat(best(j)) = bestScore(j);
			end
			vector(i,:)= feat;
		end
		feature_vector = mean(vector);
		[a,b] = sort(feature_vector);
		flagged_feature_array = zeros(k_features,1);
		start_index = 1000 - k_features + 1;
		for j = start_index : 1000
			flagged_feature_array(j + k_features - 1000) = b(j);
		end
		frame_average = zeros(number_of_frames,1);	
		for i = 1 : number_of_frames
			sum_tot = 0 ;
			for j = 1:k_features
				sum_tot = sum_tot + class_vector(i,flagged_feature_array(j));
			end
			frame_average(i) = sum_tot/k_features;
		end
		[average_score, k_frames_values] = sort(frame_average);
		k_frames = k_features;
		new_descriptor = zeros(k_frames, 1000);
		start_index = 1000 - k_frames + 1;
		for i = start_index:1000
   		   for j = 1:k_features
			new_descriptor(i +  k_frames - 1000,flagged_feature_array(j)) = class_vector(k_frames_values(i +  k_frames - 1000),flagged_feature_array(j));
		   end
		end 
                feature_vector = mean(new_descriptor);
	end			
end
