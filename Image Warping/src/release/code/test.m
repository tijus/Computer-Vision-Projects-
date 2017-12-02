%% test .mat file loading...

imRed= [];
lRed = load("../data/red.mat");
figure(1)
imshow(lRed.red);
imRed = lRed.red;

imBlue = [];
lBlue = load("../data/blue.mat");
figure(2);
imshow(lBlue.blue);
imBlue = lBlue.blue;

imGreen = [];
lGreen = load("../data/green.mat");
figure(3);
imshow(lGreen.green);
imGreen = lGreen.green;

imRGB = cat(3,imRed, imBlue, imGreen);
figure(4);
imshow(imRGB);



% A = [1:8; 11:18; 21:28; 31:38; 41:48]

%B = circshift(A,[0,30]);
%figure(4)
%imshow(B);