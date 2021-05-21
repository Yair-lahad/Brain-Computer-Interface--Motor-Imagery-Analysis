function [acc,sd] =classifyTrain(k,whichFeats,features,nTrials,labels)
%function classify features by k fold cross validation method
% input: feature matrice, specification of features to classify...
%...number of groups to classify (k), labels, number of trials
% output: accuracy and std for training and validation sets

folds= mod(randperm(nTrials),k)+1; % randomly choose folds
class=ones(1,nTrials);    % stores classifications (0=left,1=right)
trainAcc=zeros(1,k);          % stores k training accuracy
validationAcc = zeros(1,k);   % stores k validation accuracy
% start k fold cross validation process
for i=1:k
    % define validation (test) set, training set and group set
    sample=features(whichFeats,folds==i);
    training=features(whichFeats,folds~=i);
    group=labels(folds~=i);
    % classify, get back classification result and train error
    [class(folds==i),trainErr]=classify(sample',training',group','linear');
    trainAcc(i)=1-trainErr; % train accuracy
    groupSample = labels(folds==i); % labels for validation set
    validationAcc(i) = mean( class(folds==i) == groupSample' ); % validation (test) accuracy
end
% comupte total accuray and std (validation & training)
acc=[mean(trainAcc),mean(validationAcc)];
sd=[std(trainAcc),std(validationAcc)];
end