function S = get_SNP_similarity_vector_between_two_individuals(x,y,BIRDS_DATABASE)

dbid = mksqlite('open', 'SNP.db');

S = zeros(4878,1);

xID = BIRDS_DATABASE.get_bird_by_index(x);
yID = BIRDS_DATABASE.get_bird_by_index(y);

resultsX = mksqlite(dbid,strcat('select strandA,strandB from Genotypes where individual = ''',xID.ringNo,''''));
resultsY = mksqlite(dbid,strcat('select strandA,strandB from Genotypes where individual = ''',yID.ringNo,''''));

for i=1:4878
    S(i) = get_SNP_similarity(resultsX(i),resultsY(i));
end

mksqlite('close');
end