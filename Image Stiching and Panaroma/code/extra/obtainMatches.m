function [m1,m2] = obtainMatches(cX,cY,cX2,cY2,nearestKeyPoints,sortedflattenMatrix)
%% 
% obtainMatches - the fuction obtains the matches from the feature points
% Input: 
%   cX - column vector with x coordinate of circle centers for image 1
%   cY - column vector with y coordinate of circle centers for image 1
%   cX2 - column vector with x coordinate of circle centers for image 2
%   cY2 - column vector with x coordinate of circle centers for image 2
%   nearestKeyPoints - the nearest neighbourhood discriptors
%   sortedflattenMatrix - sample points given to RANSAC
% Output: 
%   m1 - matches for image 1
%   m2 - matches for image 2

%% Coding starts here
    %% Realizing the matches from the output of dist2
    for i=1:1:size(sortedflattenMatrix,2)
         [row col]= find(nearestKeyPoints == sortedflattenMatrix(1,i));
         dimVector(1,i) = row;
         dimVector(2,i) = col;
    end
    %% Forming the putative matches into a cell of N X 2
    for i=1:1:size(dimVector,2)
        display(dimVector(2,i));
        p1(1,i) = cX(dimVector(1,i));
        p1(2,i) = cY(dimVector(1,i));
        p2(1,i) = cX2(dimVector(2,i));
        p2(2,i) = cY2(dimVector(2,i));
    end
    m1=p1; % matching points from image 1
    m2=p2; % matching points from image 2
end