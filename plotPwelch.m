function plotPwelch(pwelches,f,nChannels,nClasses,classes,channels,plotScales)
% function plots each Pwelch from pwelches cell- each subplot is specific channel of specific class

fig=figure('Units', 'centimeters', 'Position', [1 1 plotScales(1) plotScales(2)*plotScales(1)]);
set(fig,'Name','Pwelch','NumberTitle','off');
sgtitle('Power Spectrums');
loc=1;  % location of subplot
for i=1:nClasses
    for j=1:nChannels
        subplot(nClasses,nChannels,loc);
        loc=loc+1;
        % plot pwelch for specific class, and a specific channel
        plot(f,mean(pwelches{i}{j},2));
        title(char(classes{i}+" "+channels{j}));
        %labels
        if i==2
            xlabel('Frequency [Hz]','FontSize',plotScales(5));
        end
    end
end
end
