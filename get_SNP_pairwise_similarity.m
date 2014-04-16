function [similarity s_counts] = get_SNP_pairwise_similarity(DATA_i,DATA_j,min_SNPs)

if size(DATA_i,2)==4
    strandA = 3;
    strandB = 4;
else
    strandA = 1;
    strandB = 2;
end

if ~exist('min_SNPs','var')
    min_SNPs = 800;
end

similarity = 0;
s_counts = 0;
for s = 1:min(size(DATA_i,1),size(DATA_j,1))
    if DATA_i(s,strandA)==-1 || DATA_i(s,strandB)==-1 || DATA_j(s,strandA)==-1 || DATA_j(s,strandB)==-1
        continue
    else
        similarity = similarity + get_SNP_similarity([DATA_i(s,strandA) DATA_i(s,strandB)],[DATA_j(s,strandA) DATA_j(s,strandB)]);
        s_counts = s_counts + 1;
    end
end

if s_counts>min_SNPs
    similarity = similarity / s_counts;
else
    similarity = nan;
end
end