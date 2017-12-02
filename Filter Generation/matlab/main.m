tic;
%% codeblock under run time analysis
% Reading Image from data folder
im = imread('../data/artgallery.jpg');
% converting image to double
im =im2double(im);
% converting image double to gray scale
im = rgb2gray(im);
% Defining number of levels to be 15
n=15;
% Defining logScales to be 2
logScales  = 2;
% Defining threshold to be 0.02
th = 0.0055; 

% Using switch to as for user options
choice = input('Enter your choice\n1. Change Filter Size\n2. Downsample Image size\n');
switch choice
    case 1
        [cX,cY,radius] = changeFilterSize(im,th,n,logScales);
        show_all_circles(im,cY,cX,radius);
    case 2
        [cX,cY,radius] = downSampleImage(im,th,n,sqrt(pi/2).^3);
        show_all_circles(im,cY,cX,radius);
    otherwise
        fprintf('Wrong choice entered');
end
%%
toc;
 


 
 
 
 
         
 
 
 
 
 

    
