function [features,iFeat,types]=extractFeatures(features,nFeatures,data,fs,featsPrmt,sInd,iFeat)
% function adds features to matrice
% input: raw data,features matrices, relevant frequency bands, start time...
%...channels to extract in order list,index to insert feature and sample rate
% output: features matrice inserted with features for all trials, index...
%...for next available feature spot in matrice and types cell of all features

types=cell(nFeatures,1);   % saves type of features
%bandpass features
for i=1:size(featsPrmt(1).chan,2)
    features(iFeat,:)=bandpower(data(:,sInd:end,featsPrmt(1).chan(i))',fs,featsPrmt(1).freqs{i});
    types{iFeat}="Band Power";
    iFeat=iFeat+1;
end
% relative log features
for i=1:2:size(featsPrmt(2).chan,2)
    % specific frequency band
    currBand=bandpower(data(:,sInd:end,featsPrmt(2).chan(i))',fs, featsPrmt(2).freqs{i});
    % power in frequencies of 0-40
    totalPower= bandpower(data(:,sInd:end,featsPrmt(2).chan(i+1))',fs, featsPrmt(2).freqs{i+1});
    % relative log power
    features(iFeat,:)=10*log10(currBand)./(10*log10(totalPower));
    types{iFeat}="Relative Log Power";
    iFeat=iFeat+1;
end
% root power features
for i=1:size(featsPrmt(3).chan,2)
    features(iFeat,:)=sqrt(bandpower(data(:,sInd:end,featsPrmt(3).chan(i))',fs, featsPrmt(3).freqs{i}));
    types{iFeat}="Root Power";
    iFeat=iFeat+1;
end
end