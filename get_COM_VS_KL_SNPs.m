function [COM KL_AG KL_AC KL_distribution_AG KL_distribution_AC comm_members_count comm_members_count_with_SNPs] = get_COM_VS_KL_SNPs(COMMUNITIES,OUTPUT,Xframes,BIRDS_DATABASE,SNP_AG_ALL,SNP_AC_ALL)

NUMBER_OF_AG_SNPS = 4031;
NUMBER_OF_AC_SNPS = 847;

comm_frames = length(COMMUNITIES);

comm_number = 0;

for frame=1:comm_frames
    if ~isempty(COMMUNITIES{frame})
        current_com_number = length(COMMUNITIES{frame});
        comm_number = comm_number + current_com_number;
    end
end

COM = zeros(comm_number,1);
KL_AG = zeros(comm_number,1);
KL_AC = zeros(comm_number,1);

KL_distribution_AG = zeros(NUMBER_OF_AG_SNPS,comm_number);
KL_distribution_AC = zeros(NUMBER_OF_AC_SNPS,comm_number);

comm_members_count =  zeros(comm_number,1);
comm_members_count_with_SNPs =  zeros(comm_number,1);

iterator = 0;
for frame=1:comm_frames
    fprintf('> frame %d out of %d\n',frame,comm_frames);
    if ~isempty(COMMUNITIES{frame})
        current_com_number = length(COMMUNITIES{frame});
        
        for k=1:current_com_number
            fprintf('\tcommunity %d out of %d... ',k,current_com_number);
            
            iterator = iterator + 1;
            
            members = COMMUNITIES{frame}{k};
            comm_members_count(iterator) = length(members);
            
            select_members_with_SNPs = create_select_statement_from_community(members,BIRDS_DATABASE,false);
            
            dbid = mksqlite('open','SNP.db');
            res = mksqlite(dbid,select_members_with_SNPs);
            mksqlite('close')
            
            members_with_SNPs = zeros(1,length(res));
            for i=1:length(res)
                aux = BIRDS_DATABASE.get_bird_by_ID(res(i).ringNo);
                members_with_SNPs(i) = aux.index;
            end
            
            comm_members_count_with_SNPs(iterator) = length(members_with_SNPs);
            
            if comm_members_count_with_SNPs(iterator)>3
                fprintf('Member completeness: %d out of %d = %.2f \n',comm_members_count_with_SNPs(iterator),...
                    comm_members_count(iterator),comm_members_count_with_SNPs(iterator)/comm_members_count(iterator));
                
                %
                W = decompress_adjacency_matrix(OUTPUT(frame).Wframes);
                COM(iterator) = get_coocurrences_network_load(W(members_with_SNPs,members_with_SNPs),...
                    Xframes(members_with_SNPs,frame));
                
                %
                [SNP_AG SNP_AC] = get_SNP_histogram_given_individuals(members_with_SNPs,BIRDS_DATABASE,'SNP.db');
                                
                KL_distribution_AG(:,iterator) = get_SNP_KL_divergence(SNP_AG_ALL,SNP_AG);
                KL_distribution_AC(:,iterator) = get_SNP_KL_divergence(SNP_AC_ALL,SNP_AC);
                
                KL_AG(iterator) = mean(KL_distribution_AG(:,iterator));
                KL_AC(iterator) = mean(KL_distribution_AC(:,iterator));
                
            else
                fprintf('Inadequate member completeness - skipping...\n');
                KL_AG(iterator) = nan;
                KL_AC(iterator) = nan;
            end
        end
    end
end

inactive = isnan(KL_AG);

COM(inactive) = [];
KL_AG(inactive) = [];
KL_AC(inactive) = [];
end