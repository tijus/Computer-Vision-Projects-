%{
%% read image 
im1 = imread('../../data/part2/house1.jpg');
image1 = rgb2gray(im2double(im1));

im2 = imread('../../data/part2/house2.jpg');
image2 = rgb2gray(im2double(im2));
%% set parameters
n=15;
% Defining logScales to be 2
logScales  = 2;
% Defining threshold to be 0.02
th = 0.01; 
sP = 500;
%%
%Haris detector code..
[cim,cX,cY] = harris(image1,logScales,th,1,0);
[cim2,cX2,cY2] = harris(image2,logScales,th,1,0);
%[cX,cY,radius] = changeFilterSize(image1,th,n,logScales);
%[cX2,cY2,radius2] = changeFilterSize(image2,th,n,logScales);
%% find descriptors
descriptors1 = find_sift(image1,[cY,cX,ones(size(cX,1))]);
descriptors2 = find_sift(image2,[cY2,cX2,ones(size(cX2,1))]);
dimVector = [];
p1 = [];
p2 = [];
%% calculating nearest neighborpoints
nearestKeyPoints = dist2(descriptors1,descriptors2);
flattenMatrix = reshape(nearestKeyPoints,1,[]);
sortedflattenMatrix = unique(sort(flattenMatrix));
sortedflattenMatrix = sortedflattenMatrix(1,1:sP);

% row vectors of image1 and col vector of image2 obtained from dist2
%% obtain matches
for i=1:1:size(sortedflattenMatrix,2)
     [row col]= find(nearestKeyPoints == sortedflattenMatrix(1,i));
     dimVector(1,i) = row;
     dimVector(2,i) = col;
end

for i=1:1:size(dimVector,2)
    display(dimVector(2,i));
    p1(1,i) = cX(dimVector(1,i));
    p1(2,i) = cY(dimVector(1,i));
    p2(1,i) = cX2(dimVector(2,i));
    p2(2,i) = cY2(dimVector(2,i));
end
%% RANSAC IMPLEMENTATION
th = 2;
[closest_pt, L, maxInliers, matches]= ransac(p1,p2,th,sP,size(im2));

%% Fundamental visulaization


% find endpoints of segment on epipolar line (for display purposes)
pt1 = closest_pt - [L(:,2) -L(:,1)] * 10; % offset from the closest point is 10 pixels
pt2 = closest_pt + [L(:,2) -L(:,1)] * 10;

% display points and segments of corresponding epipolar lines
clf;
imshow(im2); hold on;
plot(matches(:,3), matches(:,4), '+r');
line([matches(:,3) closest_pt(:,1)]', [matches(:,4) closest_pt(:,2)]', 'Color', 'r');
line([pt1(:,1) pt2(:,1)]', [pt1(:,2) pt2(:,2)]', 'Color', 'g');
%}
%% Triangulation of points in 3D space

% Reading parameters
matches = load('../../data/part2/house_matches.txt');
camMatrix1 = load('../../data/part2/house1_camera.txt');
camMatrix2 = load('../../data/part2/house2_camera.txt');

% Getting camera centers
camCenters1 = getCameraCenters(camMatrix1);
camCenters2 = getCameraCenters(camMatrix2);

% segregating matches for image 1 and 2 
x1 = matches(:,1:2);
x2 = matches(:,3:4);
x1 = [x1,ones(size(x1,1),1)];
x2 = [x2,ones(size(x2,1),1)];

% number of matches
N = size(x1,1);

trPoints = zeros(N, 3); % triangulation points
prPoints1 = zeros(N, 2); % projective points of image 1
prPoints2 = zeros(N, 2); % projective points of image 2


for i = 1:N
    p1 = x1(i,:);
    p2 = x2(i,:);
    % creating a cross product matrix for both the image
    crossProductMatrix1 = [  0   -p1(3)  p1(2); p1(3)   0   -p1(1); -p1(2)  p1(1)   0  ];
    crossProductMatrix2 = [  0   -p2(3)  p2(2); p2(3)   0   -p2(1); -p2(2)  p2(1)   0  ];    
    
    % matrix multiplication of cross product matrix and camera matrix of
    % both the images
    E = [ crossProductMatrix1*camMatrix1; crossProductMatrix2*camMatrix2 ];
    
    % applying svd to both the images
    [~,~,V] = svd(E);
    
    trPointHomography = V(:,end)'; % triangulation vector
    
    trPoints(i,:) = convertToCartesian(trPointHomography); % reducing the dimension
    % calculating the points of correspondance between the both the image
    prPoints1(i,:) = convertToCartesian((camMatrix1 * trPointHomography')');
    prPoints2(i,:) = convertToCartesian((camMatrix2 * trPointHomography')');
    
end

% plotting the points of both the image and the camera centers
plotTriangulation(camCenters1,camCenters2,trPoints);

% finding the residual distance of both the images.
dis1 = diag(dist2(matches(:,1:2), prPoints1));
dis2 = diag(dist2(matches(:,3:4), prPoints2));
display(['Mean Residual 1: ', num2str(mean(dis1))]);
display(['Mean Residual 2: ', num2str(mean(dis2))]);


