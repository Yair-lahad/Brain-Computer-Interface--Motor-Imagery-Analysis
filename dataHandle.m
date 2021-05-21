function [outputData,fs]= dataHandle(classes,nClasses)
% this function handle data given from motor imagery EEG recordings
% input is classes we want from data and nClasses
% returns sampling rate and cell which each row is a diffrent class
% each class (row) is a matrice with size: trials x (time*sampling rate) x nChannels

data=load('motor_imagery_train_data.mat');
data=data.P_C_S;
EEG_mat=data.data(:,:,[1 2]);% exclude 3rd channel- not relevant for project
fs=data.samplingfrequency;    % sampling rate
outputData=cell(nClasses,1);  % allocate data
for i=1:nClasses
    % filter data only from input classes (left and right)
    currInd=strcmpi(classes(i),data.attributename); % row will be 1 if class exists in data, if not row is 0.
    trials=data.attribute(currInd,:) == 1; %trials locataion who belongs to current class
    outputData{i}=EEG_mat(trials,:,:); % data containing trials from class
end
end
