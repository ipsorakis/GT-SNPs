function SELECT_STATEMENT = create_select_statement_from_random_SNPS(SNPS_DATABASE,parenthesis_flag)

if nargin<2
    parenthesis_flag = true;
end

randomised_indices = randperm(4878);
SNP_indices = randomised_indices(1:500);


N = 500;

if parenthesis_flag
    SELECT_STATEMENT = ' (select ID from SNPs where (';
else
    SELECT_STATEMENT = ' select ID from SNPs where (';
end

for i=1:N
    current_SNP = SNPS_DATABASE.get_SNP_by_index(SNP_indices(i));
    
    SELECT_STATEMENT = strcat(SELECT_STATEMENT,' ID = ''',current_SNP.ID,''' ');
    
    if i~=N
        SELECT_STATEMENT = strcat(SELECT_STATEMENT,' or ');
    end
end

if parenthesis_flag
    SELECT_STATEMENT = strcat(SELECT_STATEMENT,'))');
else
    SELECT_STATEMENT = strcat(SELECT_STATEMENT,')');
end

end