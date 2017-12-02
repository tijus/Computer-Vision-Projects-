function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features
    trainingSetLength = length(train_imagenames);
    train = zeros(trainingSetLength);
    train_featuresCell = cell(1,trainingSetLength);
    L=2;
    dictSize = size(dictionary);
    for i =1:1:trainingSetLength
        % replacing .jpg in an image name to .mat
        changedFileName = strrep(train_imagenames{i},'.jpg','.mat');
        fullFileName = strcat('../data/',changedFileName);
        wordMap = load(fullFileName);
        h = getImageFeaturesSPM(L+1,wordMap.wordMap,dictSize(1));
        train_featuresCell{1,i} = h;
    end
    
    train_features = cell2mat(train_featuresCell);
    
    % Saving the result to vision.mat file
	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end