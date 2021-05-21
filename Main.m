clear all;
close all;
clc;
%% Final Project - Analysis of Motor Imagery Data

% Gali Winterberger      - id 315679571
% Yair Lahad             - id 205493018

%% Setting variables
classes={'Left','Right'};
nClasses=length(classes);
channels={'C3','C4'};
nChannels=length(channels);
titles=getTitles(classes,nClasses,channels,nChannels); % function arranges titles
% function handling data
[data,fs]=dataHandle(classes,nClasses);
nLeft=size(data{1},1);                  % number of left trials
nRight=size(data{2},1);                 % number of right trials
labels=[zeros(nLeft,1);ones(nRight,1)]; % 0 for left 1 for right
orderData=[data{1};data{2}];            % combine data for features search (left then right)
nTrials=size(orderData,1);              % total trials in data
timeVec=1:size(data{1},2);              % time vector
minFreq=0.5;                            % mimimum frequency
maxFreq=40;                             % maximum frequency
jump=0.1;
f=minFreq:jump:maxFreq;                 % frequency vector

% Visualization variables
nRandTrials=20;              %number of random trials for visualization part
% Pwelch variables
pwelches= cell(nClasses,1);  % cell of cells- each row is a pwelch for a class (left,right)
startInd=4*fs;               % starting time when the data is relevant for anaylize
pwWindow=2*fs;               % window size for creating pwelch
pwOverlap=1*fs;              % overlap size for creating pwelch
% Spectogram variables
specs=cell(nChannels+nClasses,1);  % cell for all spectograms
currInd=0;                         % index to insert next spectogram

% features variables
iFeature=1;      % current feature index ( also total number of current features minus one)
nFeatures=9;     % limit number of features to create ( try to avoid overfitting)
features= zeros(nFeatures,nTrials);  % allocate features
% Manually extract features (learned from Visualization/Pwelch/Spectogram section and Research)
% bandpass features
featsPrmt(1).freqs={[15 18],[15 18],[8 10],[8 10],[10 12]}; % bands to extract from
featsPrmt(1).chan=[2 1 1 2 2];                      % which channel to extract a feature from
% relative log power features
featsPrmt(2).freqs={[15 18],[0 40],[15 18],[0 40]}; % bands to extract from
featsPrmt(2).chan=[1 1 2 2];                        % which channel to extract a feature from
% root power features
featsPrmt(3).freqs={[14 18],[14 18]};               % bands to extract from
featsPrmt(3).chan=[1 2];                            % which channel to extract a feature from

% Pca variables
nComp=3;                     % number of dimensions to reduce in pca
% Plot variables
labelsSize=10;
scatterSize=8;
titleSize=12;
paper_width = 16.5; %cm
figure_ratio  = 0.6;
plotScales=[paper_width;figure_ratio;labelsSize;scatterSize;titleSize];

%% Visualisation
% visualize each class with random trials taken from C3 and C4 channels
for i=1:nClasses
    visualizeClass(timeVec/fs,data{i},plotScales,classes,channels,i,maxFreq,nRandTrials);
end

%% Pwelch
for i=1: nClasses
    % cell- each row is a Pwelch matrice per channel (C3,C4)
    pwelches{i}=getPwelch(data{i},fs,f,pwWindow,pwOverlap,nChannels,startInd); % function cumputes pwelch
end
%all Pwelches
plotPwelch(pwelches,f,nChannels,nClasses,classes,channels,plotScales); % function plots figure with all Pwelches
% pwelches per channel
fig=figure('Units', 'centimeters', 'Position', [1 1 plotScales(1) plotScales(2)*plotScales(1)]);
set(fig,'Name','Pwelch per Channel','NumberTitle','off');
for i=1:nChannels
    % function adds to figure a subplot of Pwelches (all classes) from a given channel
    plotChannelPwelch(pwelches,f,fs,nChannels,channels,classes,nClasses,i);
end

%% Spectrogram
for i=1:nClasses
    % function adds spectograms from all channels in a class to spectograms cell
    [specs,currInd]=getSpectogram(specs,data{i},currInd,fs,nTrials,nChannels);
end
% plot all spectograms in a figure and plots diffrence of spectograms
plotSpectogram(specs,timeVec/fs,f,nChannels,nClasses,titles,plotScales)
% spectogram diffrences
for i=1:nChannels
    % plots for given Channel diffrences between classes spectograms
    plotSpecsDiff(specs,i,i+nClasses,timeVec/fs,f,titles,channels,i,plotScales)
end

%% Features
% function extracts features from start time and defined parameters into features matrice
[features,iFeature,types]=extractFeatures(features,nFeatures,orderData,fs,featsPrmt,startInd,iFeature);

%% Histograms
%function plots histograms for all features (each feature -left and right trials on a single subplot)
plotFeaturesHistogram(features,nFeatures,plotScales,nLeft,types,classes);

%% Pca
%function plotting Principal Component Algorithm of features matrice
% zscore features before activate pca process
plotPCA(zscore(features,0,2),plotScales,nComp,classes,nLeft);

%% Classifier Training
% Classification variables
k=10;                          % number of groups for k fold
whichFeats=1:nFeatures;        % choose specific features to classify after features extraction process
% for calssification call classifyTrain function
[acc,sd] = classifyTrain(k,whichFeats,features,nTrials,labels);
% report accuracy and std
msg = char("Training accuracy: "+round(acc(1)*100,2)+" " +char(177)+round(sd(1)*100,2)+"%");
disp(msg);
msg2 = char("Validation accuracy: "+round(acc(2)*100,2)+" " +char(177)+round(sd(2)*100,2)+"%");
disp(msg2);

%% Classifier Testing
testData = load ('motor_imagery_test_data');
testData = testData.data;
testFeats=zeros(nFeatures,size(testData,1));     % same amount of features, trials as test data length
iTestFeat=1;                                     % current place to insert a feature
% extract test features from test data with exact features we used for learning
[testFeats,~,~]=extractFeatures(testFeats,nFeatures,testData,fs,featsPrmt,startInd,iTestFeat);
% classify: testFeats (sample), features (training) labels (group)
testLabels = classify(testFeats(1:nFeatures,:)',features(1:nFeatures,:)',labels,'linear'); % (0=left, 1=right)
