function plotPCA(features,plotScales,nComp,classes,nLeft)
% main input: features matrice, number of component to reduce
% output: plots data after pca reduction, for 2D\3D projection

plotScales(2)=0.48;
fig=figure('Units', 'centimeters', 'Position', [1 1 plotScales(1) plotScales(2)*plotScales(1)]);
set(fig,'Name','Pca','NumberTitle','off');
sgtitle('Pca','FontSize',plotScales(5)+5);
% matlab function pca returns ncomp eigen vectors
eigs=pca(features','NumComponents',nComp);
% reduce features matrice to nComp dimesions
reducedF= eigs'*(features-mean(features,2));
%3D
subplot(1,2,1);
% visualize 3D and seperate between classes (left and right)
scatter3(reducedF(1,1:nLeft),reducedF(2,1:nLeft),reducedF(3,1:nLeft),plotScales(4),'g','filled');
hold on;
scatter3(reducedF(1,nLeft+1:end),reducedF(2,nLeft+1:end),reducedF(3,nLeft+1:end),plotScales(4),'m','filled');
title('3D Projection','FontSize',plotScales(5));
% labels
xlabel('PC-1','FontSize',plotScales(3));
ylabel('PC-2','FontSize',plotScales(3));
zlabel('PC-3','FontSize',plotScales(3));
%2D
subplot(1,2,2);
% visualize 2D and seperate between classes (left and right)
scatter(reducedF(1,1:nLeft),reducedF(2,1:nLeft),plotScales(4),'g','filled');
hold on;
scatter(reducedF(1,nLeft+1:end),reducedF(2,nLeft+1:end),plotScales(4),'m','filled');
title('2D Projection','FontSize',plotScales(5));
% labels
xlabel('PC-1','FontSize',plotScales(3));
ylabel('PC-2','FontSize',plotScales(3));
legend(classes);

end