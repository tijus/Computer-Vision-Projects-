function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

% TODO Implement your code here
[row col dim] = size(img);
result=zeros(row,col);
filterImage = extractFilterResponses(img, filterBank);
% parsing the image matrix along rows and columns
for i=1:1:row
    for j=1:1:col
        containerImageVector = [];
        dict = [];
        % parsing i,j element of the 3D image matrix along Z axis
        for k=1:1:60
            containerImageVector = [containerImageVector;filterImage(i,j,k)];
        end
        containerImageVector = containerImageVector';
        dict = dictionary;
        
        % Finding the minimum Euclidean distance between image vector
        % across z axis and dictionary
        a = pdist2(containerImageVector,dict);
        [mins,indexes] = min(a);
        
        % assigning the index of the dictionary having minimum Euclidean
        % distance
        result(i,j) = indexes;
    end
end
% Returning result
wordMap = result;    
end
