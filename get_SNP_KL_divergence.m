function KL = get_SNP_KL_divergence(SNP1,SNP2)

total_SNPs = size(SNP1,1);

KL = zeros(total_SNPs,1);

for i=1:total_SNPs
   KL(i) = get_KL_divergence(SNP1(i,:),SNP2(i,:));
%    if KL(i)<0
%       KL(i) 
%    end
end
end