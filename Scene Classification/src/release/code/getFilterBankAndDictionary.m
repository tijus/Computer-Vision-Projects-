function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    % TODO Implement your code here
    filterBank  = createFilterBank();
    [row col dim] = size(imPaths);
    %reading 1000 images from the data
    row = 1000;
    
    % value of K to be put into k-mean clustering is 200
    K=200;
    
    % value of alpha random pixel to be applied on an image is 75
    alpha = randperm(75);
    clusteredResult=cell(row);
    h = waitbar(0,'Please wait...');
    for i=1:1:row
        % Reading image from imagePaths
        clusterData = [];
        img = imread(imPaths{i,1});
        img = imresize(img, [512 512]);
        img = im2double(img);
        [rows, column, dimension] = size(img);
        % converting grey scale image to color image
        if dimension == 1
            img = cat(3, img, img, img);
        end
        filterbank = createFilterBank();
        resultant_image = extractFilterResponses(img, filterbank);
        waitbar(i / row);
        % Reading 3D image matrix accross Z axis
        for j=1:1:60
            feedback = resultant_image(:,:,j);
            alphaArray = feedback(alpha);
            clusterData = [clusterData;alphaArray];
        end
        clusterData = clusterData';
        clusterResult{i,1}=clusterData;
        clusterMat = cell2mat(clusterResult);
    end
    close(h);
    % call to kmean clustering forming a dictionary
    [~,dictionary] =  kmeans(clusterMat, K, 'EmptyAction','drop'); 
    
end

