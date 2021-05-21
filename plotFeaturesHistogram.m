function plotFeaturesHistogram(features,nFeatures,plotScales,nLeft,types,classes)
% function main input is features matrice,nFeatures
% function plots histogram per feature with class seperation(left\right)

hist=figure('Units', 'centimeters', 'Position', [1 1 plotScales(1) plotScales(2)*plotScales(1)]);
set(hist,'Name','Histograms','NumberTitle','off');
sgtitle('Histograms','Fontsize',plotScales(5)+2);
for i=1:nFeatures
    subplot(nFeatures/3,3,i);
    histogram(features(i,1:nLeft),'BinWidth',1); % histogram left trials
    hold on;
    histogram(features(i,nLeft+1:end),'BinWidth',1); % histogram right trials
    title(char("Feat N. " + num2str(i)+ ", " + types(i)));
    if i==3
        legend(classes);
    end
    % labels
    if mod(i,3)==1
        ylabel('Counts','Fontsize',plotScales(3));
    end
    if i>=7
        xlabel('Feature value','Fontsize',plotScales(3));
    end
end