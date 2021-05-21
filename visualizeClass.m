function visualizeClass(time_vec,data,plotScales,classes,channels,loc,maxFreq,nRandTrials)
% function plots (nRandTrials) of random trials from EEG Data in a specific class...
%...plots data from all channels (C3 and C4) on each subplot

fig=figure('Units', 'centimeters', 'Position', [1 1 plotScales(1) plotScales(2)*plotScales(1)]);
set(fig,'Name',['Class- ' classes{loc}],'NumberTitle','off');
plotScales(5)=14;
sgtitle(char(classes(loc)+ " class"));
rows=nRandTrials/5;  % order the subplots
cols=nRandTrials/rows;
randTrials=randperm(size(data,1),nRandTrials); % get random indexes representing trials
for i=1:nRandTrials
    subplot (rows,cols,i);
    %plots all channels (C3 and C4) from current trial in one subplot
    hold on;
    for chan=1:size(channels,2)
        plot(time_vec,data(randTrials(i),:,chan));
    end
    hold off;
    %set axes limits,axes labels and legend
    ylim([-maxFreq/2,maxFreq/2]);
    if i==cols
        legend(channels);
    end
    han=axes(fig,'visible','off');
    han.XLabel.Visible='on';
    han.YLabel.Visible='on';
    ylabel('Voltage [muV]','FontSize',plotScales(5));
    xlabel('Time [sec]','FontSize',plotScales(5));
end
hold off;
end