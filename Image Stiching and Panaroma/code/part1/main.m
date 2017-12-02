
%% Reading images from the source
im1 = imread('../../data/part1/hill/1.jpg');
image1 = rgb2gray(im2double(im1));

im2 = imread('../../data/part1/hill/2.jpg');
image2 = rgb2gray(im2double(im2));
%% Defining parameters
n=15;
% Defining logScales to be 2
logScales  = 2;
% Defining threshold to be 0.02
th = 0.02; 
sP = 500;
%% Calculating putative matches
[cX,cY,radius] = changeFilterSize(image1,th,n,logScales);
[cX2,cY2,radius2] = changeFilterSize(image2,th,n,logScales);

descriptors1 = find_sift(image1,[cY,cX,radius]);
descriptors2 = find_sift(image2,[cY2,cX2,radius2]);

nearestKeyPoints = dist2(descriptors1,descriptors2);
flattenMatrix = reshape(nearestKeyPoints,1,[]);
sortedflattenMatrix = unique(sort(flattenMatrix));
sortedflattenMatrix = sortedflattenMatrix(1,1:sP);

%% Row vectors of image1 and Column vector of image2 obtained from dist2
%  Here we obtain the matches..
[p1,p2] = obtainMatches(cX,cY,cX2,cY2,nearestKeyPoints,sortedflattenMatrix);
%% RANSAC IMPLEMENTATION
th = 4;
homoGraphyMatrix = ransac(p1,p2,th,sP);
%% Stitching images ..
stitchImage(homoGraphyMatrix,im1,im2);
