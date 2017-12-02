function X = calculateFundamental(p1,p2,index)
%%  
% calculateFundamental - the function calculates fundamental matrix for
% estimation.
% Input: 
%   p1 - putative matches for image 1
%   p2 - putative matches for image 2
%   index  - indexes of the four sample points obtained during RANSAC
% Output:
%   X - 1X9 vectors input for 
%% Coding starts here..
% applying the homogenuity condition to find F
F = [];
display(size(index,2));
for i=1:1:size(index,2)
    display(i);
    x1 = p1(1,index(1,i));
    y1 = p1(2,index(1,i));
    x2 = p2(1,index(1,i));
    y2 = p2(2,index(1,i));
    F(i,:) = [x1*x2,x1*y2,x1,y1*x2,y1*y2,y1,x2,y2,1];
    display(F(i,:));
end
[U,S,V] = svd(F);
%% applying Rank 2 constraint
F = reshape(V(:,9),3,3)';
[FU,FS,FV] = svd(F);
FS(3,3) = 0;
X = FU*FS*FV';

end