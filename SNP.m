classdef SNP < handle
    
    properties
        ID
        chromosome
        type
        
        index
        
        MA
        MAF
    end
    
    methods
        function obj = SNP(tuple,index)
            obj.ID = tuple.ID;
            obj.chromosome = tuple.chromosome;
            obj.type = tuple.type;
            
            if nargin<2
                obj.index = -1;
            else
                obj.index = index;
            end
            
            obj.MAF = 'N/A';
            obj.MAF = nan;
        end
    end
end