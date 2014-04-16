function s = get_SNP_similarity(strands_i,strands_j)

SNP_X = convert_SNP_strands_to_integer_set(strands_i);
SNP_Y = convert_SNP_strands_to_integer_set(strands_j);

number_of_doubles = sum(sum(SNP_X,2)==2) + sum(sum(SNP_Y,2)==2);

s_table = zeros(2);

if isstruct(strands_i)
    
    if strcmp(strands_i.strandA,strands_j.strandA)
        s_table(1,1) = 1;
    end
    
    if strcmp(strands_i.strandA,strands_j.strandB)
        s_table(1,2) = 1;
    end
    
    if strcmp(strands_i.strandB,strands_j.strandA)
        s_table(2,1) = 1;
    end
    
    if strcmp(strands_i.strandB,strands_j.strandB)
        s_table(2,2) = 1;
    end
    
else
    
    if strands_i(1)==strands_j(1)%strcmp(strands_i.strandA,strands_j.strandA)
        s_table(1,1) = 1;
    end
    
    if strands_i(1)==strands_j(2)%strcmp(strands_i.strandA,strands_j.strandB)
        s_table(1,2) = 1;
    end
    
    if strands_i(2)==strands_j(1)%strcmp(strands_i.strandB,strands_j.strandA)
        s_table(2,1) = 1;
    end
    
    if strands_i(2)==strands_j(2)%strcmp(strands_i.strandB,strands_j.strandB)
        s_table(2,2) = 1;
    end
    
end

s = sum(sum(s_table)) - number_of_doubles;

if s<0
    s=0;
end

s = s/2;

end
