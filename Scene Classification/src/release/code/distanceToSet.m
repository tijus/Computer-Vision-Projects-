function [histInter] = distanceToSet(wordHist, histograms)
% Compute distance between a histogram of visual words with all training image histograms.
% Inputs:
% 	wordHist: visual word histogram - K * (4^(L+1) − 1 / 3) × 1 vector
% 	histograms: matrix containing T features from T training images - K * (4^(L+1) − 1 / 3) × T matrix
% Output:
% 	histInter: histogram intersection similarity between wordHist and each training sample as a 1 × T vector

	% TODO Implement your code here
	
    [row col dim] = size(histograms);
    
    % repeating the wordHist along the columns
    wordHistN = repmat(wordHist,[1 col]);
    
    % finding minimum distance between histograms and repeated wordHist
    minDist = bsxfun(@min, histograms(:,:),wordHistN);
    
    % summing the resultant histogram to form a minimum distance vector
    histInter = sum(minDist); 
end