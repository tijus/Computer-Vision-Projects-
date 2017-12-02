function [cartesianCoord] = convertToCartesian(homographyCoord)
%%  
% convertToCartesian - the function converts homographical coordinates to 
% cartesian cordinates with one dimension less.
% Input: 
%   homographyCoord - homograhical coordinates
% Output:
%   cartesianCoord - Cartesian coordinates
    %% Coding starts here..
    col= size(homographyCoord, 2) - 1;    
    row = size(homographyCoord);
    % Normalizing coordinates by dividing every row by the last entry in that row
    for i=1:row
        normalizedCoord(i,:) = homographyCoord(i,:)./homographyCoord(i,end);
    end
    cartesianCoord = normalizedCoord(:,1:col);
end