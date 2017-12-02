function [cX,cY,radius] = changeFilterSize(im,th,n,logScales)
%%  
% changeFilterSize - the function uses changing the size of the filter
% approach to detect blobs.
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

    for idx = 1:1:n 
         size = 5*logScales+1;
         % Ideally filter should be odd so that its effect is identical
         if mod(ceil(size),2)~=0
             filtSize = floor(size);
             logFilterBank{idx} = fspecial('log', filtSize, logScales);
         else
             filtSize = floor(size);
             logFilterBank{idx} = fspecial('log', filtSize, logScales);
         end
         spaceScale{idx} = logScales;
         % Scale normalized gaussian filter
         resultantImage{idx} = logScales^2*imfilter(im,logFilterBank{idx,1},'replicate');
         resultantImage{idx} = resultantImage{idx}.*resultantImage{idx};
         % Applying ordfilt2 (an input parameter for nms implementation) 
         nmsImage{idx}=ordfilt2(resultantImage{idx,1},9,ones(3,3));
         logScales = logScales*sqrt(pi/2);    
    end

    % Applying Non-maximum Suppression
    resultantImage = applyNMS(resultantImage,nmsImage,n);

    % Taking the maximum of the nms calculated at each layer
    [maxNum,maxIndex] = max(cat(3,resultantImage{:}),[],3);

    % Taking the maximum greater such that it is greater than threshold
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
