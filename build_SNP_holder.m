function SNPS_DATABASE = build_SNP_holder()

SNPS_DATABASE = SNP_holder;


dbid = mksqlite('open', 'SNP.db');

results = mksqlite(dbid,'select * from SNPs');

total_SNPs = length(results);

for i=1:total_SNPs
   
    snp = SNP(results(i),i);
    
    SNPS_DATABASE.add_SNP(snp)
    
    progressbar(i/total_SNPs);
end


mksqlite('close');

end