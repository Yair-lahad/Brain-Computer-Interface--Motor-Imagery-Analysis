function plotChannelPwelch(pwelches,f,fs,nChannels,channels,classes,nClasses,currChan)
% function adds to figure a subplot of Pwelches (all classes) from a given channel
% data taken from pwelches cell

for i=1:nClasses
    hold on;
    subplot(nChannels,1,currChan);
    % every iteration adds class pwelch for current specific channel
    plot(f,mean(pwelches{i}{currChan},2));
    xlabel ('Frequency [Hz]');
end
title(['Power Spectrums of channel- ' channels{currChan}]);
legend(classes);
% improve grid to know which frequency is important
ax=gca;
ax.XTick=0:2:fs/2;
grid on;
%hold off;
end