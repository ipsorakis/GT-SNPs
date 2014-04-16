function SNPS_DATABASE = calculate_MAF(SNPS_DATABASE)

matlabpool size

dbid = mksqlite('open','SNP.db');

if dbid ~=1
    error('Could not open database file')
end

SNPS_list = mksqlite(dbid,'select * from SNPs');



AA = 1;
AX = 2;
XX = 3;

TOTAL_SNPS = length(SNPS_list);

MA_LIST = zeros(TOTAL_SNPS,1);
MAF_LIST = zeros(TOTAL_SNPS,1);

completed_snps = 0;

for snp_index=1:TOTAL_SNPS
    tic
    SNP_ID = SNPS_list(snp_index).ID;
    SNP_type = SNPS_list(snp_index).type;
       
    GENOTYPES = mksqlite(dbid,strcat('select * from Genotypes where SNP = ''',SNP_ID,''''));    
    
    SNP_distribution = zeros(3,1);
    
    for gen_index=1:length(GENOTYPES)
        
        current_allele = strcat(GENOTYPES(gen_index).strandA,GENOTYPES(gen_index).strandB);
        
        switch current_allele
            case 'AA'
                SNP_distribution(AA)=SNP_distribution(AA)+1;
                %
            case 'AG'
                SNP_distribution(AX)=SNP_distribution(AX)+1;
            case 'GA'
                SNP_distribution(AX)=SNP_distribution(AX)+1;
            case 'AC'
                SNP_distribution(AX)=SNP_distribution(AX)+1;
            case 'CA'
                SNP_distribution(AX)=SNP_distribution(AX)+1;
                %
            case 'CC'
                SNP_distribution(XX)=SNP_distribution(XX)+1;
            case 'GG'
                SNP_distribution(XX)=SNP_distribution(XX)+1;
        end
    end
    
    SNP_distribution = SNP_distribution/sum(SNP_distribution);
    
    [MAF MA_index] = min(SNP_distribution);
    
    CURRENT_SNP = SNPS_DATABASE.get_SNP_by_ID(SNP_ID);
    
    CURRENT_SNP.MAF = MAF;
    
    switch SNP_type
        case 'AG'
            if MA_index == 1
                CURRENT_SNP.MA = 'AA';
            elseif MA_index == 2
                CURRENT_SNP.MA = 'AG';
            elseif MA_index == 3
                CURRENT_SNP.MA = 'GG';
            end
        case 'AC'
            if MA_index == 1
                CURRENT_SNP.MA = 'AA';
            elseif MA_index == 2
                CURRENT_SNP.MA = 'AC';
            elseif MA_index == 3
                CURRENT_SNP.MA = 'CC';
            end
    end
    
    SNPS_DATABASE.update_SNP(CURRENT_SNP);
    
    completed_snps = completed_snps + 1
    toc
end

mksqlite('close')
end