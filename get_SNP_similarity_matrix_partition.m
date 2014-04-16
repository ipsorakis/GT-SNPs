function S = get_SNP_similarity_matrix_partition(A_partition)

DATA = A_partition.DATA;
N = size(A_partition.A,1);
S = nan*ones(N);

for i=1:N
    
    i_global = A_partition.row_index_manager.get_original_index(i);
    
    i_indices = DATA(:,1)==i_global;
    
    if sum(i_indices)==0
        continue
    end        
    
    DATA_i = DATA(i_indices,:);
    
    for j=1:N
        
        if A_partition.is_diagonal && i>=j
            continue;
        end
        
        j_global = A_partition.col_index_manager.get_original_index(j);
        
        j_indices = sparse(DATA(:,1)==j_global);
        
        if sum(j_indices)==0
            continue
        end
        
        DATA_j = DATA(j_indices,:);
        
        S(i,j) = get_SNP_pairwise_similarity(DATA_i,DATA_j);
    end
end
end