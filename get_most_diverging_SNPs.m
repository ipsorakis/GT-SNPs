function SNPs = get_most_diverging_SNPs(KL_distribution)

num_SNPs = size(KL_distribution,1);
num_comm = size(KL_distribution,2);

SNPs = zeros(num_SNPs,1);

for i=1:num_comm
    SNPs = SNPs + (KL_distribution(:,i)>=prctile(KL_distribution(:,i),90));        
end

end