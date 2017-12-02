function [cX, cY, radius] = downSampleImage(im,th,n,logScales)
%%  
% downSampleImage - the function uses downsampling the image approach to
% detect blobs.
% Input: 
%   im - gray scale image
%   th - threshold (a scalar)
%   n  - number of scale levels in the scale space pyramid
%   logScales - value of the sigma scales
% Output:
%   cX - column vector with x coordinates of circle centers
%   cY - column vector with y coordinates of circle centers
%   radius - column vector with radii of the circle
%% Coding starts here

    logFilterBank = cell(n,1); % contains the filter at various levels
    spaceScale = cell(n,1); % contains the scale at various levels
    resultantImage = cell(n,1); % contains the result of the image
    nmsImage = cell(n,1); % contains the non-maximum supression response of an image
    k=2;
    
    for idx=1:1:n
         logFilterBank{idx} = fspecial('log', [7,7], 2);
         spaceScale{idx} = logScales;
         % Downsampling Image
         resizedImage= imresize(im,ceil(1/k));
         % Scale normalized gaussian filter
         resultantImage{idx} = imfilter(resizedImage,logFilterBank{idx,1},'replicate');
         % Upsampling Resultant Image
         resultantImage{idx} = imresize(resultantImage{idx},size(im));
         resultantImage{idx} = resultantImage{idx}.*resultantImage{idx};
         % Applying ordfilt2
         nmsImage{idx}=ordfilt2(resultantImage{idx,1},9,ones(3,3));
         % Scaling the log scale
         logScales = logScales*sqrt(pi/2);
         % Scale k
         k=k*sqrt(pi/2);
    end

    % Applying Non-maximum Suppression
    resultantImage = applyNMS(resultantImage,nmsImage,n);

    % Taking the maximum of the nms calculated at each layer
    [maxNum,maxIndex] = max(cat(3,resultantImage{:}),[],3);

    [cX cY] = find(maxNum>th); % x and y coordinates of the circle centers
    sigma = cell(numel(cX),1);

    for itr =1:1:numel(cX)
         scaleLevel = maxIndex(cX(itr),cY(itr));
         sigma{itr} = spaceScale{scaleLevel}; 
    end
    
    % calculating radius for blob circles
    radius = cell2mat(sigma);
    radius = sqrt(2)*radius;
end