is_consistent = check_GENOTYPE_DATA_consistency(GENOTYPE_DATA);

if is_consistent
   
    pfun = @get_SNP_similarity_matrix_partition;
    
    A = build_distributed_adjacency_matrix(BIRDS_DATABASE.birds_number,GENOTYPE_DATA,pfun);
    
end