function camCenters = getCameraCenters(cameraMat)
%% 
% getCameraCenters - This function is used to get the camera centers
% Input: 
%   cameraMat - 3 X 4 camera matrix
% Output:
%   camCenters - 1 X 3 camera centers (across x,y, and z dimension).
%% Coding starts here
[~,~,V] = svd(cameraMat);
camCenters = V(:,end);  
camCenters = convertToCartesian(camCenters');
end