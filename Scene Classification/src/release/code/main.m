
%% Calling visual words
%I = imread('../data/garden/sun_bgwhceaudanflans.jpg');
%im = im2double(I);
%dictionary = load('dictionary.mat');
%filterbank = createFilterBank();
%wordmap = getVisualWords(im,filterbank,dictionary.dictionary);
%imagesc(wordmap);

%% Call for  getImageFeatures
I = imread('../data/garden/sun_bavqqcxmiixxeirr.jpg');
im = im2double(I);
dictionary = load('dictionary.mat');
filterbank = createFilterBank();
wordmap = getVisualWords(im,filterbank,dictionary.dictionary);
dictsize = size(dictionary.dictionary); 
h = getImageFeatures(wordmap,dictsize(1));
plot(h);

%% Call for getImageFeaturesSPM
 %I = imread('../data/garden/sun_bavqqcxmiixxeirr.jpg');
 %im = im2double(I);
 %dictionary = load('dictionary.mat');
 %filterbank = createFilterBank();
 %dict = dictionary.dictionary;
 %wordmap = getVisualWords(im,filterbank,dict);
 %dictsize = size(dictionary.dictionary);
 %L = 2;
 %h = getImageFeaturesSPM(L+1,wordmap,dictsize(1));
 %%
 %% Call for distanceToSet
% trainimages = load('../data/traintest.mat');
% trainingSetLength = length(trainimages.train_imagenames);
% train = zeros(trainingSetLength);
% histCell = cell(1,trainingSetLength);
% L=2;
% dictionary = load('dictionary.mat');
% dictSize = size(dictionary.dictionary);
% for i =1:1:trainingSetLength
%     changedFileName = strrep(trainimages.train_imagenames{i},'.jpg','.mat');
%     fullFileName = strcat('../data/',changedFileName);
%     wordMap = load(fullFileName);
%     h = getImageFeaturesSPM(L+1,wordMap.wordMap,dictSize(1));
%     histCell{1,i} = h;
% end
% hist = cell2mat(histCell);
% changedTestFileName = strrep(trainimages.test_imagenames{1,1},'.jpg','.mat');
% fullTestFileName = strcat('../data/',changedTestFileName);
% wordMapTest = load(fullTestFileName);
% testVector = getImageFeaturesSPM(L+1,wordMapTest.wordMap,dictSize(1));
% minDistVector = distanceToSet(testVector,hist);
% whos minDistVector;
% display(minDistVector);


% evaluation = evaluateRecognitionSystem();
% display(evaluation);

%% extract filter responses

%I = imread('../data/ice_skating/sun_absxwroozitnpiwm.jpg');
%im = im2double(I);
%filterbank = createFilterBank();
%filterResponses = extractFilterResponses(im,filterbank);
%montage(filterResponses,'Size',[4 5]);
 
 
 


