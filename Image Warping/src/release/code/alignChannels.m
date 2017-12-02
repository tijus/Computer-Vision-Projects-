function [rgbResult] = alignChannels(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a
%       color image, compute the best aligned result with minimum
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%       corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here
row = 277;
col = 344;
modGreen = [];
modBlue = [];
indexGreen = zeros(2);
indexBlue = zeros(2);
subRed = red(row:row+256,col:col+256);
indexGreen = sSD(green, subRed, row, col);
indexBlue = sSD(blue, subRed, row, col);
modGreen = circshift(green,[row-indexGreen(1),col-indexGreen(2)]);
modBlue = circshift(blue,[row-indexBlue(1),col-indexBlue(2)]);

rgbResult = cat(3,red, modGreen, modBlue);

%image is resized to 0.5 times its intensity for avoiding the affixing of
%the image to the screen.
rgbResult=imresize(rgbResult,0.5);
imshow(rgbResult);
end

%%
function [result] = sSD(Matrix, subMatrix, row, col)

fssd = 10000000000000;
result = zeros(2);
for i=row-30:1:row+30
    for j=col-30:1:col+30
        b = Matrix(i:256+i,j:256+j)-subMatrix;
        c = b.^2;
        d = sum(sum(c));  
        if d<fssd
            fssd = d;
            row1 = i;
            col1 = j;
        end            
    end
end
result(1) = row1;
result(2) = col1;
end 



