function converted_vector = convert_decisionProb_percentage(decision_values, threshold)
	converted_vector = zeros(size(decision_values,1),1);
	for i = 1:size(decision_values,1)
		if((decision_values(i,1)) > threshold)
			converted_vector(i) = 1;
		end
	end
end
