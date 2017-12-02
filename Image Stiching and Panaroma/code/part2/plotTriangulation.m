function[ ] = plotTriangulation(camCenters1,camCenters2,triangPoints)
%% 
% applyNMS - the function plots the triangulation into 3D space.
% Input: 
%   camCenters1 - camera centers for image 1
%   camCenters2 - camera centers for image 2
%   triangPoints - triangulation points for both the images
%% Coding starts here

    figure; axis equal;  hold on; 
    plot3(-triangPoints(:,1), triangPoints(:,2), triangPoints(:,3), '*r');
    plot3(-camCenters1(1), camCenters1(2), camCenters1(3),'*g');
    plot3(-camCenters2(1), camCenters2(2), camCenters2(3),'*b');
    grid on; xlabel('x'); ylabel('y'); zlabel('z'); axis equal;
    
end