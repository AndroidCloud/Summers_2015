function classifier_list = load_level_2_classifier(top_k, TypeA, TypeB)

        var_name = strcat('classifier_list_',lower(TypeA),'_',lower(TypeB));
        a = load(fullfile('matrixes',strcat(var_name,'.mat')));
        list = a.(var_name);
        classifier_list = {};
        for i=1:size(list,2)
                classifier_list{i} = list{i}(end-top_k+1:end);
        end
end

