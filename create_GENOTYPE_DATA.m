function DATA = create_GENOTYPE_DATA(SNPS_DATABASE_GLOBAL,BIRDS_DATABASE_GLOBAL)
matlabpool size

BIRD_COL = 1;
SNP_COL = 2;
STRANDA_COL = 3;
STRANDB_COL = 4;

dbid = mksqlite('open','SNP.db');
results = mksqlite(dbid,'select * from Genotypes');
%results = mksqlite(dbid,'select * from Genotypes limit 1000');
mksqlite('close')

Z = length(results);
%Z = 1000;

DATA = zeros(4,Z);

parfor z=1:Z
    BIRDS_DATABASE = BIRDS_DATABASE_GLOBAL;
    SNPS_DATABASE = SNPS_DATABASE_GLOBAL;
    
    current_bird = BIRDS_DATABASE.get_bird_by_ID(results(z).individual);
    
    if ~isempty(current_bird)
        
        current_SNP = SNPS_DATABASE.get_SNP_by_ID(results(z).SNP);
        
        switch results(z).strandA
            case 'A'
                strandA = 1;
            case 'C'
                strandA = 2;
            case 'G'
                strandA = 3;
            otherwise
                strandA = nan;
        end
        
        switch results(z).strandB
            case 'A'
                strandB = 1;
            case 'C'
                strandB = 2;
            case 'G'
                strandB = 3;
            otherwise
                strandB = nan;
        end
        
        
        data_point = zeros(4,1);
        data_point(BIRD_COL) = current_bird.index;
        data_point(SNP_COL) = current_SNP.index;
        data_point(STRANDA_COL) = strandA;
        data_point(STRANDB_COL) = strandB;
        
    else
        data_point = nan*ones(4,1);
    end
    
    DATA(:,z) = data_point;    
end

inactive_datapoints = isnan(sum(DATA))';
DATA = DATA';
DATA(inactive_datapoints,:) = [];

end