function Fmatrix = calculateNormalizedFundamental(m1,m2,index,sizeImage)
%%  
% calculateNormalizedFundamental - the function calculates fundamental matrix 
% using normalized eight point algorithm.
% Input: 
%   m1 - putative matches for image 1
%   m2 - putative matches for image 2
%   index  - indexes of the four sample points obtained during RANSAC
%   sizeImage - size of the image
% Output:
%   X - 1X9 vectors input for 
%% Coding starts here..
H = [];
width = sizeImage(1,2);
height = sizeImage(1,1);
m1 = [m1;ones(1,size(m1,2))];
m2 = [m2;ones(1,size(m2,2))];
% forming a normaliztion vector
% Scaling image by the factor of 2
% Translating the matches to the image center. 
N = [2/width 0 -1; 0 2/height -1; 0 0 1];
% applying Normalization on matches of image 1 and 2
p1 = N*m1;
p2 = N*m2;
% applying the homogenuity condition to find F
for i=1:1:size(index,2)
    x1 = p1(1,index(1,i));
    y1 = p1(2,index(1,i));
    x2 = p2(1,index(1,i));
    y2 = p2(2,index(1,i));
    H(i,:) = [x1*x2,x1*y2,x1,y1*x2,y1*y2,y1,x2,y2,1];
end
[U,S,V] = svd(H);
F = reshape(V(:,9),[3,3])';
%Rank 2 constraint
[FU,FS,FV] = svd(F);
FS(3,3) = 0;
X = FU*FS*FV';
% Denormalize
Fmatrix=N'*X*N;

end