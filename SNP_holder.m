classdef SNP_holder < handle
    
    properties
        SNPs_lookup;
        SNPs_list;
        
        SNPs_number;
    end
    
    methods
        function obj = SNP_holder()
            obj.SNPs_lookup = hashtable;
            obj.SNPs_list = cell(0);
            obj.SNPs_number = 0;
        end
        
        function add_SNP(obj,SNP)
            obj.SNPs_lookup = put(obj.SNPs_lookup,SNP.ID,SNP);
            
            obj.SNPs_number = obj.SNPs_number + 1;
            
            if SNP.index == -1
                SNP.index = obj.SNPs_number;
            end
            
            obj.SNPs_list{SNP.index} = SNP;
        end
        
        function e = exists(obj,ID)
            e = ~isempty(get(obj.SNPs_lookup,ID));
        end
        
        function b = get_SNP_by_ID(obj,ID)
            b = get(obj.SNPs_lookup,ID);
        end
        
        function b = get_SNP_by_index(obj,index)
            b = obj.SNPs_list{index};
        end
        
        function update_SNP(obj,aSNP)
            if isempty(get(obj.SNPs_lookup,aSNP.ID))
                disp('no such SNP exists')
                return
            end
            
            obj.SNPs_lookup = put(obj.SNPs_lookup,aSNP.ID,aSNP);
            obj.SNPs_list{aSNP.index} = aSNP;
        end
    end
end