function [specs,currInd]=getSpectogram(specs,data,currInd,fs,nTrials,nChannels)
% input: spectograms cell,data from a specific class,currInd to insert...
%... sampling rate, nTrials,nChannels
% output: specs updated with inserted spectograms for all channels...
%... also currInd represents the last cell which we insert a spectogram

% setting variables
sg_window = 1*fs;
sg_overlap = floor(0.8*fs);
s = spectrogram(data(1,:,1),sg_window,sg_overlap,[],fs,'yaxis'); %only to get sizes
for i=1:nChannels
    currSpec=i+currInd;  % each call needs to insert in correct location in specs
    specs{currSpec}=zeros(size(s,1),size(s,2),fs/2);  % allocate current data
    for trial=1:(nTrials/2)
        %get spectogram per trial using matlab function
        [~,~,~,specs{currSpec}(:,:,trial)]=spectrogram(data(trial,:,i),sg_window,sg_overlap,[],fs,'power');
    end
    % convert units to dB and get average for all trials
    specs{currSpec}=mean(10*log10(specs{currSpec}),3);
end
currInd=currInd+nChannels;  % update index after all channels inserted
end