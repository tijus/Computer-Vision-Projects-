% Problem 1: Image Alignment

%% 1. Load images (all 3 channels)
red = [];  % Red channel
green = [];  % Green channel
blue = [];  % Blue channel

lRed = load("../data/red.mat");
red = lRed.red;

lGreen = load("../data/green.mat");
green = lGreen.green;

lBlue = load("../data/blue.mat");
blue = lBlue.blue;

%% 2. Find best alignment
% Hint: Lookup the 'circshift' function
rgbResult = alignChannels(red, green, blue);

%% 3. Save result to rgb_output.jpg (IN THE "results" folder)
set(gcf, 'Color', [1 1 1]);
set(gcf, 'PaperPositionMode', 'auto');
outname = fullfile('../results/', 'rgb_output.jpg');
saveas(gcf, outname);
