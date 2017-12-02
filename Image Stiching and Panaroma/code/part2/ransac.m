%% optimization of the code required....
function [closestPt,Line,maxInliers,Matches] = ransac(p1,p2,th,samplePoints,imSize)
%%  
% ransac - the function is the RANSAC algorithm implementation
% Input: 
%   p1 - putative matches of image 1
%   p2 - putative matches of image 2
%   th  - threshold set to find maximum inlier ratio 
%   samplePoints - number of points having the minimum distance obtained 
%                  from dist2
%   imSize - size of the image
% Output:
%   closestPt - The closest transformed points that corresponds to image 1
%   Line - epipolar line (N X 3 matrix)
%   maxInliers - maximum inlier ratio calculated during ransac
%   Matches - matches of image 1
%% Coding starts here
%% Defining parameters
k = 100000;
inlierRatio = cell(k,2);
iterations = 1;
max = 0;
finalHM = [];
distanceMatrix = cell(samplePoints,3);
%% RANSAC implementation starts here..
while(iterations<=k)
    display(iterations);
    storedPoints = [];
    %storedIndex = setdiff(storedIndex,x);
    x = randperm(samplePoints,8);
    F = calculateNormalizedFundamental(p1,p2,x,imSize);
    matches = [p1',p2'];
    N = size(matches,1);
    L = (F * [matches(:,1:2) ones(N,1)]')'; % transform points from
    % the first image to get epipolar lines in the second image

    % find points on epipolar lines L closest to matches(:,3:4)
    L = L ./ repmat(sqrt(L(:,1).^2 + L(:,2).^2), 1, 3); % rescale the line
    pt_line_dist = abs(sum(L .* [matches(:,3:4) ones(N,1)],2));
    
    closest_pt = matches(:,3:4) - L(:,1:2) .* repmat(pt_line_dist, 1, 2);
    %% calculating the number of inliers
    counter = 0;        
    %calculating ratios
    for i=1:1:size(pt_line_dist,1)
       if(pt_line_dist(i,1)<th)
           counter = counter+1;
       end
    end
    %% calculating the maximum inliers
    if counter>max
        max = counter;
        maxClosePts = closest_pt;
        finalL = L;
        ptdist = pt_line_dist;
        m = matches;
    end
    
    iterations = iterations + 1;
end
% x = find(ptdist<th);
% display(sum(x)/size(ptdist,1));
distance = [ptdist,maxClosePts,finalL,m];
% display(sum(ptdist)/size(ptdist,1));
distance = sortrows(distance,1);
% display(distance)
% display(max);
closestPt = distance(:,2:3);
Line = distance(:,4:6);
maxInliers = max;
Matches = distance(:,7:10);
end


