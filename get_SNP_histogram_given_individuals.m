function [AG_SNP_hist AC_SNP_hist AG_SNP_samples AC_SNP_samples] = get_SNP_histogram_given_individuals(members,BIRDS_DATABASE,dbfile)

%% initialise
SELECT_MEMBERS = create_select_statement_from_community(members,BIRDS_DATABASE);

%
dbid = mksqlite('open', dbfile);
%TOTAL_SNPs = 4878;



TOTAL_AC_SNPs = 847;
TOTAL_AG_SNPs = 4031;

AG_SNP_hist = zeros(3,TOTAL_AG_SNPs);
AC_SNP_hist = zeros(3,TOTAL_AC_SNPs);

AG_SNP_samples = zeros(TOTAL_AG_SNPs,1);
AC_SNP_samples = zeros(TOTAL_AC_SNPs,1);

AG_SNPs = mksqlite(dbid,'select ID from SNPs where type=''AG''');
AC_SNPs = mksqlite(dbid,'select ID from SNPs where type=''AC''');

%% AG
for SNP_index = 1:TOTAL_AG_SNPs
    current_SNP = AG_SNPs(SNP_index).ID;
    
    SNP_QUERY = ...
        strcat('select strandA,strandB from Genotypes,Individuals where Genotypes.SNP = ''',current_SNP,...
        ''' and Individuals.ringNo = Genotypes.individual and Individuals.ringNo in ',SELECT_MEMBERS);
    
    SNP_data = mksqlite(dbid,SNP_QUERY);
    
    [p total_samples] = get_SNP_hist(SNP_data,'AG');
            
    AG_SNP_samples(SNP_index) = total_samples;
    AG_SNP_hist(:,SNP_index) = p/total_samples;
end

%% AC
for SNP_index = 1:TOTAL_AC_SNPs
    current_SNP = AC_SNPs(SNP_index).ID;
    
    SNP_QUERY = ...
        strcat('select strandA,strandB from Genotypes,Individuals where Genotypes.SNP = ''',current_SNP,...
        ''' and Individuals.ringNo = Genotypes.individual and Individuals.ringNo in ',SELECT_MEMBERS);
    
    SNP_data = mksqlite(dbid,SNP_QUERY);
    
    [p total_samples] = get_SNP_hist(SNP_data,'AC');
            
    AC_SNP_samples(SNP_index) = total_samples;    
    AC_SNP_hist(:,SNP_index) = p/total_samples;
end

%% finalise

AG_SNP_hist = AG_SNP_hist';
AC_SNP_hist = AC_SNP_hist';

mksqlite('close')
end

function [p active_samples] = get_SNP_hist(SNP_data,type_flag)

AA = 1;
AG = 2;
GG = 3;

AC = 2;
CC = 3;

p = zeros(3,1);

total_samples = length(SNP_data);

active_samples = 0;

for i=1:total_samples
    strandA = SNP_data(i).strandA;
    strandB = SNP_data(i).strandB;
    
    if strcmp(strandA,'0') || strcmp(strandB,'0')
        continue;
    end
    
    active_samples = active_samples + 1;
    
    switch type_flag
        case 'AG'
            if strcmp(strandA,'A') && strcmp(strandB,'A')
                p(AA) = p(AA) + 1;
            elseif strcmp(strandA,'G') && strcmp(strandB,'G')
                p(GG) = p(GG) + 1;
            elseif (strcmp(strandA,'A') && strcmp(strandB,'G')) || (strcmp(strandA,'G') && strcmp(strandB,'A'))
                p(AG) = p(AG) + 1;
            end
        case 'AC'
            if strcmp(strandA,'A') && strcmp(strandB,'A')
                p(AA) = p(AA) + 1;
            elseif strcmp(strandA,'C') && strcmp(strandB,'C')
                p(CC) = p(CC) + 1;
            elseif (strcmp(strandA,'A') && strcmp(strandB,'C')) || (strcmp(strandA,'C') && strcmp(strandB,'A'))
                p(AC) = p(AC) + 1;
            end
    end    
end

end