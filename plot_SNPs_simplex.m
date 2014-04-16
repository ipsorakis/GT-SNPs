function plot_SNPs_simplex(SNP1,SNP2)

plot_3d_simplex;

hold on
scatter3(SNP1(:,1),SNP1(:,2),SNP1(:,3),'b')
scatter3(SNP2(:,1),SNP2(:,2),SNP2(:,3),'r')

total_SNPs = size(SNP1,1);

for i=1:total_SNPs
    line([SNP1(i,1) SNP2(i,1)], [SNP1(i,2) SNP2(i,2)], [SNP1(i,3) SNP2(i,3)],'Color',[0 0 0]);
end
hold off
end
