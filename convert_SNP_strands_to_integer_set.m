function i = convert_SNP_strands_to_integer_set(SNP)

A = 1;
C = 2;
G = 3;

i = zeros(3,2);

if isstruct(SNP)
    switch SNP.strandA
        case 'A'
            i(A,1) = 1;
        case 'C'
            i(C,1) = 1;
        case 'G'
            i(G,1) = 1;
    end
    
    switch SNP.strandB
        case 'A'
            i(A,2) = 1;
        case 'C'
            i(C,2) = 1;
        case 'G'
            i(G,2) = 1;
    end
else
    switch SNP(1)
        case A
            i(A,1) = 1;
        case C
            i(C,1) = 1;
        case G
            i(G,1) = 1;
    end
    
    switch SNP(2)
        case A
            i(A,2) = 1;
        case C
            i(C,2) = 1;
        case G
            i(G,2) = 1;
    end
end

end