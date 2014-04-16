function plot_SNP_on_simplex(SNP,type,color)

if nargin<2
    type = 'AG';
    color = 'b';
elseif nargin<3
    color = 'b';
end

plot_3d_simplex;

hold on
scatter3(SNP(:,1),SNP(:,2),SNP(:,3),color);

xlabel('AA');
if strcmp(type,'AG')
    ylabel('AG');
    zlabel('GG');
else
    ylabel('AC');
    zlabel('CC');
end
hold off

end