function plotSpectogram(specs,timeVec,f,nChannels,nClasses,titles,plotScales)
% fucntion plots spectogram from all given classes and channels

% set figure to plot spectograms
fig=figure('Units', 'centimeters', 'Position', [1 1 plotScales(1) plotScales(2)*plotScales(1)]);
set(fig,'Name','Spectograms','NumberTitle','off');
sgtitle('Spectograms');
for i=1:size(specs,1)
    subplot (nChannels,nClasses,i);
    % represents spectogram using imagesc function
    imagesc(timeVec,f,specs{i});
    title(titles(i));
    axis xy;    % flip axes
    c=colorbar; % adds colorbar
    % labels
    han=axes(fig,'visible','off');
    han.XLabel.Visible='on';
    han.YLabel.Visible='on';
    xlabel ('Time [sec]','fontSize',plotScales(5));
    ylabel ('Frequency [Hz]','fontSize',plotScales(5));
    if mod(i,2)==0
        ylabel(c,'Power [dB]','fontSize',plotScales(5));
    end
end
end
