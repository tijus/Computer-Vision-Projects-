function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses

% TODO Implement your code here

% converting the image to L*a*b

[row1,col1,dim1] = size(img);
% Converting grey scale image to rgb
if dim1==1
    img = repmat(img,[1 1 3]);
end

imrgb = RGB2Lab(img);
[row,col,dim] = size(filterBank);
modImageArray = cell([row col dim]);

%Applying filterbank to the image
for i=1:1:row
    modImageArray{i,1} = imfilter(imrgb, filterBank{i,1});
end

% converting a modified image cell into a W x H x N * 3
filterResponses = cat(3,modImageArray{:});

end
