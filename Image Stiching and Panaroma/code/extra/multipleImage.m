
%% Defining Parameters
n=15;
% Defining logScales to be 2
logScales  = 2;
% Defining threshold to be 0.02
th = 0.02; 
sP = 500;
%% Reading all image from file incrementally
files = dir('../../data/part1/pier/*.jpg');  
image = cell(length(files),1);
cX = cell(length(files),1);
cY = cell(length(files),1);
descriptors = cell(length(files),1);
radius = cell(length(files),1);
nearestKeyPoints = cell(length(files)-1,1);
sortedflattenMatrix = cell(length(files)-1,1);
stichedImage = cell(length(files)-1,1);
%% calculating putative matches 
for i = 1 : length(files)
    filename = strcat('../../data/part1/pier/',files(i).name);
    image{i,1} = imread(filename);
    im = rgb2gray((im2double(image{i,1})));
    [X,Y,r] = changeFilterSize(im,th,n,logScales);
    cX{i,1} = X;
    cY{i,1} = Y;
    radius{i,1} = r;
    descriptors{i,1} = find_sift(im,[cY{i,1},cX{i,1},radius{i,1}]);
end
[row col] = size(image{1,1});

for i=1:length(files)-1
    nearestKeyPoints{i,1} = dist2(descriptors{i,1},descriptors{i+1,1});
    flattenMatrix = reshape(nearestKeyPoints{i,1},1,[]);
    sortedMatrix = unique(sort(flattenMatrix));
    sortedflattenMatrix{i,1} = sortedMatrix(1,1:sP);
end
%% applying RANSAC to all the images sequentially and stiching the corresponding image
finalImage = [];
stichedImage = [];
for i=1:size(sortedflattenMatrix,1)
    [p1,p2] = obtainMatches(cX{i,1},cY{i,1},cX{i+1,1},cY{i+1,1},nearestKeyPoints{i,1},sortedflattenMatrix{i,1});
    th = 2;
    homoGraphyMatrix = ransac(p1,p2,th,sP);
    if i==1
        stichedImage = stitchImage(homoGraphyMatrix,image{i,1},image{i+1,1});
        stichedImage = imresize(stichedImage,[300 400]);
    else
        resizedImage = imresize(image{i,1},[300 400]);
        stichedImage = stitchImage(homoGraphyMatrix,stichedImage,resizedImage);    
    end
end
imshow(stichedImage);




