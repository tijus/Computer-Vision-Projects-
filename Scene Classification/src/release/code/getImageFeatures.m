function [h] = getImageFeatures(wordMap, dictionarySize)
% Compute histogram of visual words
% Inputs:
% 	wordMap: WordMap matrix of size (h, w)
% 	dictionarySize: the number of visual words, dictionary size
% Output:
%   h: vector of histogram of visual words of size dictionarySize (l1-normalized, ie. sum(h(:)) == 1)

	% TODO Implement your code here
    [rows col dim] = size(wordMap);
    hist = zeros(1, dictionarySize);
    
    % Calculating the frequency of an image matrix  for forming histogram
    for i = 1:1:rows
        for j = 1:1:col
            hist_index = wordMap(i,j);
            hist(1,hist_index) = hist(1,hist_index)+1;
        end
    end
    
    % Normalizing Histogram
    h = hist/norm(hist,1);
end