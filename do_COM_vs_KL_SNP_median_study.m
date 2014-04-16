function KL_vals = do_COM_vs_KL_SNP_median_study(COM,KL)

N = size(COM,1);

%m = zeros(N,1);

[y indices] = sort(COM);

COM_sorted = y;
KL_sorted = KL(indices);

KL_vals = zeros(N,2);

intervals = 0:.1:1;

end_index = 1;
for i=1:9
    start_index = end_index; % 1 
    %minval = intervals(i);
    maxval = intervals(i+1); % .1
    
    end_index = find(COM_sorted>maxval,1);
    
    if isempty(end_index)
        end_index = length(COM_sorted);
    else
        end_index = end_index-1;
    end        
    
    KL_vals(start_index:end_index,1) = KL_sorted(start_index:end_index);
    KL_vals(start_index:end_index,2) = i;
    
    %boxplot(KL_vals)        
end

boxplot(KL_vals(:,1),KL_vals(:,2),'notch','on');

end