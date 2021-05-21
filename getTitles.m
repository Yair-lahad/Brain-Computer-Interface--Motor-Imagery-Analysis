function titles=getTitles(classes,nClasses,channels,nChannels)
% returns titles for project- combination of all class with all channels

titles=cell(nClasses+nChannels,1);
k=1;
for i=1:nClasses
    for j=1:nChannels
        titles{k}=append(classes{i},' ',channels{j});
        k=k+1;
    end
end
titles=titles';
end