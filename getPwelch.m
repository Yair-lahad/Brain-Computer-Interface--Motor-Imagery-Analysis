function pwCell=getPwelch(data,fs,f,pwWindow,pwOverlap,nChannels,startInd)
% this function get data of EEG recordings with rows as number of channels...
%... also recives startInd sampling rate and frequency vector.
% returns pwelch cell- each row represnts Pwelch matrice for a channel.

pwCell=cell(nChannels,1);
for i=1:nChannels
    pwCell{i}=pwelch(data(:,startInd:end,i)',pwWindow,pwOverlap,f,fs);
end
end
