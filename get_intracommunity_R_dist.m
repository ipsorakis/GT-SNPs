function [R_dist R_hist PAIRS PAIRS_COM] = get_intracommunity_R_dist(Sim_SNP,COMMUNITIES,frame_range)

total_frames = length(COMMUNITIES);
if ~exist('frame_range','var')
    frame_range = [1 total_frames];
end

Sim_SNP = 2*(decompress_adjacency_matrix(Sim_SNP) - 0.5);

r_range = 0:0.05:1;

R_hist = zeros(length(r_range),1);

PAIRS = get_triu_vector(Sim_SNP);
PAIRS(isnan(PAIRS)) = [];

PAIRS_COM = [];

for t=frame_range(1):frame_range(end)
    
    g = COMMUNITIES{t};
    K = length(g);
    for k=1:K
        nodes = g{k};
        C = length(nodes);
        if C<2
            continue
        end
        
        for ci=1:C-1
            for cj=ci+1:C
                x = nodes(ci);
                y = nodes(cj);
                
                r = Sim_SNP(x,y);
                
                if ~isnan(r)
                    PAIRS_COM = [PAIRS_COM;r];
                    
                    dist_index = find(r_range>r,1)-1;
                    R_hist(dist_index) = R_hist(dist_index) + 1;
                end
            end
        end
    end
end

R_dist = R_hist/sum(R_hist);

end