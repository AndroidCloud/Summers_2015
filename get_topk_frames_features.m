function [k_frames_values, b] = get_topk_frames_features(video_index, classes)
		load(fullfile('./frame_features/',strcat('features_vid',num2str(video_index),'.mat'))); 
		number_of_frames = size(vector_video,1)
                k_features = 30;
                k_frames = 30;
		class_vector = vector_video;
                for i = 1 : number_of_frames
                        [bestScore, best] = sort(class_vector(i,:));
                        feat = zeros(size(class_vector,2),1);
                        for j=801:1000
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
		fid = fopen(strcat('video_',num2str(video_index),'.txt'),'w');
		for i=981:1000
			fprintf(fid,'%s\n',classes.description{b(i)});
		end
		fclose(fid);
		
		mov=VideoReader(strcat('/media/anirudh/FADCE45CDCE41523/Honours/Google_Research/Change_YouTubeClips/vid',num2str(video_index),'.avi'));
		qwe=mov.read;
		ii = 1;
		DataFolder=['vid',num2str(video_index)];
		mkdir(DataFolder)
		for i = number_of_frames - 30 + 1:number_of_frames
   			filename = [sprintf('%03d',ii) '.jpg'];
   			fullname = fullfile(strcat('./vid',num2str(video_index)),filename);
			imwrite(qwe(:,:,:,i),fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
   			ii = ii+1;
		end
		imageNames = dir(fullfile(strcat('./vid',num2str(video_index)),'*.jpg'));
		imageNames = {imageNames.name}';
		imageNames		
		outputVideo = VideoWriter(fullfile('.',strcat(num2str(video_index),'.avi')));
		outputVideo.FrameRate = 1; 
		open(outputVideo)
		for ii = 1:length(imageNames)
   			img = imread(fullfile(strcat('./vid',num2str(video_index)),imageNames{ii}));
  			 writeVideo(outputVideo,img);
		end
		close(outputVideo)

end
