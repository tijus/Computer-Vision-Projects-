function finalImage = stitchImage(homoGraphyMatrix,im1,im2)
%% 
% stitchImage - this fuction stiches images into a panaroma
% Input: 
%   homoGraphyMatrix - the optimum homoGraphyMatrix Obtained from RANSAC
%   im1 - RGB image 1
%   im2 - RGB image 2
%% Coding starts here
    %% Selecting the closest points in correspondance
    points = cell2mat(sortrows(homoGraphyMatrix,1));
    x1 = points(1:4,2);
    y1 = points(1:4,3);
    x2 = points(1:4,4);
    y2 = points(1:4,5);
    %%  Stiching implementation 
    T = maketform('projective',[y2 x2], [y1 x1]);
    [im2t,xdataim2t,ydataim2t]=imtransform(im2,T);
    %figure(4),imshow(im2t);
    % xdataim2t and ydataim2t store the bounds of the transformed im2
    xdataout=[min(1,xdataim2t(1)) max(size(im1,2),xdataim2t(2))];
    ydataout=[min(1,ydataim2t(1)) max(size(im1,1),ydataim2t(2))];
    % Transform both images with the computed xdata and ydata
    im2t=imtransform(im2,T,'XData',xdataout,'YData',ydataout);
    im1t=imtransform(im1,maketform('affine',eye(3)),'XData',xdataout,'YData',ydataout);
    % Taking the average of both the images
    finalImage = im1t/2 + im2t/2;
    % visualizing image
    figure, imshow(finalImage);
    
end