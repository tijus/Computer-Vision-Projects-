function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
    % sliced Image Cell
    slicedImage = cell(21,1);
    % cell of the histogram formed from sliced image
    histCell = cell(21,1);
    % temporary histogram cell used for computation
    temphistCell= cell(21,1);
    hist = [];
    [rows col dim] = size(wordMap);
    
% For Layer, L=2 the rows and columns should be divided by 4
rowsplit = rows/4;
colsplit = col/4;

% Splitting the rows and columns of the image matrix and parsing along the
% row. Saving the histogram of the sliced image into histogram cell and 
% applying the multiplication factor of 1/2 for L=2
for i = 1:4:16
    for j = 1:rowsplit:rows
        slicedImage{i,1} = wordMap(floor(j):floor(j+rowsplit-1),1:floor(colsplit));
        histCell{i,1} = getImageFeatures(slicedImage{i,1},dictionarySize);
        histCell{i,1} = histCell{i,1}*0.5;
        slicedImage{i+1,1} = wordMap(floor(j):floor(j+rowsplit-1),floor(colsplit+1):floor(2*(colsplit)));
        histCell{i+1,1} = getImageFeatures(slicedImage{i+1,1},dictionarySize);
        histCell{i+1,1} = histCell{i+1,1}*0.5;
        slicedImage{i+2,1} = wordMap(floor(j):floor(j+rowsplit-1),floor(2*colsplit+1):floor(3*colsplit));
        histCell{i+2,1} = getImageFeatures(slicedImage{i+2,1},dictionarySize);
        histCell{i+2,1} = histCell{i+2,1}*0.5;
        slicedImage{i+3,1} = wordMap(floor(j):floor(j+rowsplit-1),floor(3*colsplit+1):col);
        histCell{i+3,1} = getImageFeatures(slicedImage{i+3,1},dictionarySize);
        histCell{i+3,1} = histCell{i+3,1}*0.5;
    end
end

% For Layer, L=1 the rows and columns should be divided by 2
rowsplit = rows/2;
colsplit = col/2;

% Splitting the rows and columns of the image matrix and parsing along the
% row. Saving the histogram of the sliced image into histogram cell and 
% applying the multiplication factor of 1/4 for L=1
for i=1:2:4
    for j=1:rowsplit:rows
        slicedImage{i+16,1} = wordMap(floor(j):floor(j+rowsplit-1),1:floor(colsplit));
        histCell{i+16,1} = getImageFeatures(slicedImage{i+16,1},dictionarySize);
        histCell{i+16,1} = histCell{i+16,1}*0.25;
        slicedImage{i+17,1} = wordMap(floor(j):floor(j+rowsplit-1),floor(colsplit+1):col);
        histCell{i+17,1} = getImageFeatures(slicedImage{i+17,1},dictionarySize);
        histCell{i+17,1} = histCell{i+17,1}*0.25;
    end
end

% For Layer, L=0 the whole image needs to be taken
slicedImage{21,1} = wordMap(:,:);

% Splitting the rows and columns of the image matrix and parsing along the
% row. Saving the histogram of the sliced image into histogram cell and 
% applying the multiplication factor of 1/4 for L=0
histCell{21,1} = getImageFeatures(slicedImage{21,1},dictionarySize);
histCell{21,1} = histCell{21,1}*0.25;
for i = 1:1:21
    temphist = cell2mat(histCell(i,1));
    temphist = temphist';
    temphistCell{i,1} = temphist;
end
hist = cell2mat(temphistCell);

% Normalize the resultant histogram
h = hist/norm(hist,1); 
end

