function resultantImage = applyNMS(resultantImage,nmsImage,numLevel)
%% 
% applyNMS - the fuction implements non-maximum suppression of a scaled
% space image
% Input: 
%   resultantImage - scaled space image cell
%   nmsImage - ordfilt2 applied image cell 
%   numLevel - number of levels in the scaled space pyramid 
%% Coding starts here

% Taking the maximum of each scale
 [maxImage,maxImageindex] = max(cat(3, nmsImage{:}), [], 3);
 
% Applying non maximum supression to each scale
    for idx=1:1:numLevel
        comparisionMatrix = (resultantImage{idx}==maxImage); 
        resultantImage{idx} = resultantImage{idx}.*comparisionMatrix;
    end
end