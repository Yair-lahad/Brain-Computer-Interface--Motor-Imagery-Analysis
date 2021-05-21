function plotSpecsDiff(specs,leftInd,rightInd,timeVec,f,titles,channels,i,plotScales)
% this function plots diffrences of spectograms from a specific...
%...channel (i) between left and right classes

plotScales(5)=16;   % update fontsize
% set figure to plot diffrences
fig=figure('Units', 'centimeters', 'Position', [1 1 plotScales(1) plotScales(2)*plotScales(1)]);
set(fig,'Name',['Spectogram Diff -' channels{i}],'NumberTitle','off');
sgtitle(char(titles(leftInd)+ " - " + titles(rightInd)),'fontSize',plotScales(5));  % title
% visualize spectogram using imagesc function
imagesc(timeVec,f,specs{leftInd}-specs{rightInd});
axis xy;    % flip axes
c=colorbar; % adds colorbar
% set labels
ylabel(c,'Power [dB]','fontSize',plotScales(5));
xlabel ('Time [sec]','fontSize',plotScales(5));
ylabel ('Frequency  [Hz]','fontSize',plotScales(5));
end




