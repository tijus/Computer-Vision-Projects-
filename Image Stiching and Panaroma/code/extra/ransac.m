function optimumDistanceMatrix = ransac(p1,p2,th,samplePoints)
%%  
% ransac - the function is the RANSAC algorithm implementation
% Input: 
%   p1 - putative matches of image 1
%   p2 - putative matches of image 2
%   th  - threshold set to find maximum inlier ratio 
%   samplePoints - number of points having the minimum distance obtained 
%                  from dist2
% Output:
%   optimumDistanceMatrix - the distance matrix containing distance, and
%   putative matches of the highest inlier ratio.
%% Coding starts here

k = 10000; % Maximum number of iterations
inlierRatio = cell(k,2);
iterations = 1;
max = 0;
finalHM = [];
optimumDistance = [];
%% RANSAC iterations starts here..
while(iterations<=k)
    %display(iterations);
    x = [];
    storedPoints = [];
    HM=[];
    H=[];
    x = randperm(samplePoints,4);
    %% Homography normalization
    H = calculateHomography(p1,p2,x);
    HM = reshape(H,[3,3]);
    HM = HM';
    HM = HM./HM(3,3);
    %% Forming the transformed points
    for i=1:1:samplePoints
       X=[];
       Xt=[];
       X = [p1(1,i),p1(2,i),1];
       Xt = HM*X';
       Xt = Xt./Xt(3);
       storedPoints = [storedPoints, Xt] ;
    end
    %% Calculating the sum of squared distance / residuals
    distance = cell(samplePoints,7);
    for i=1:1:samplePoints
       distance{i,1} = sqrt((storedPoints(1,i) - p2(1,i))^2+(storedPoints(2,i) - p2(2,i))^2);
       distance{i,2} = p1(1,i);
       distance{i,3} = p1(2,i);
       distance{i,4} = storedPoints(1,i);
       distance{i,5} = storedPoints(2,i);
    end
    %% Calculating the number of inliers of each iterations
    counter = 0;   
    sum = 0;
    %calculating ratios
    for i=1:1:size(distance,1)
       if(distance{i,1}<th)
           counter = counter+1;
           sum = sum+distance{i,1};
       end
    end
    %% Selecting parameters of the maximum inlier ratio
    if counter>max
        max = counter;
        finalSum = sum;
        optimumDistance = distance;
    end
    %%
    iterations = iterations + 1;
end

% display(max); %Displaying maximum inliers
% display(finalSum/max); % Finding mean inlier residual
optimumDistanceMatrix = optimumDistance;
end


