function F = fit_fundamental(matches,sizeImage)
%%  
% fit_fundamental - this function fits the fundamental matrix for ground
% truth estimation.
% Input: 
%   matches - putative matches of image 1 and 2
%   sizeImage  - size of an image
% Output:
%   F - 1X9 vectors input for 
%% Coding starts here..
    p1 = [];
    p2 = [];
    p1(1,:) = matches(:,1);
    p1(2,:) = matches(:,2);
    p2(1,:) = matches(:,3);
    p2(2,:) = matches(:,4);
    
    %% Uncomment for finding fundamental estimation
    F = calculateFundamental(p1,p2,[1:size(matches,1)]);
    %% Uncomment for finding normalized fundamental estimation.
    %F = calculateNormalizedFundamental(p1,p2,[(1:size(matches,1))],sizeImage);
    
end
