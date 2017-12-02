function X = calculateHomography(p1,p2,index)
%% Preparing a homography matrix
%%  
% calculateHomography - the function calculates homography matrix for
% estimation.
% Input: 
%   p1 - putative matches for image 1
%   p2 - putative matches for image 2
%   index  - indexes of the four sample points obtained during RANSAC
% Output:
%   X - 1X9 homogenized vector
%% Coding starts here..
    % solving for X' = HX homogenious relation
    H = [];
    for i=1:1:size(index,2)
        H(2*i-1,:) = [p1(1,index(1,i)), p1(2,index(1,i)), 1, 0, 0, 0, -p1(1,index(1,i))*p2(1,index(1,i)), -p1(2,index(1,i))*p2(1,index(1,i)), -p2(1,index(1,i))]; % odd rows
        H(2*i,:) = [0, 0, 0, p1(1,index(1,i)), p1(2,index(1,i)), 1, -p1(1,index(1,i))*p2(2,index(1,i)), -p1(2,index(1,i))*p2(2,index(1,i)), -p2(2,index(1,i))]; % even rows
    end
    % Singular value decomposition of H
    [U,S,V] = svd(H);
    X = V(:,9);
end