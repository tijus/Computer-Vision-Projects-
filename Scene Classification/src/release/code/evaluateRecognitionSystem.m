function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');

	% TODO Implement your code here
    % Forming a confusion matrix of size 8X8
    confusion = zeros(8,8);
    for i=1:1:length(test_imagenames)
        % Finding out the actual class name
         fullTestFileName = strcat('../data/',test_imagenames{i,1});
         substr = eraseBetween(test_imagenames{i,1},'/','.jpg');
         subsubstr = erase(substr,'/.jpg');
         
         %Finding out the predicted class name
         myGuess = guessImage(fullTestFileName);
         Guess = strrep(myGuess,'[My Guess]:','');
         
         % Finding index of the predicted class using mapping cell
         indexX = find(ismember(mapping,Guess));
         
         % Finding index of the actual class using mapping cell
         indexY = find(ismember(mapping,subsubstr));
         
         % Forming a confusion matrix
         confusion(indexX,indexY) =confusion(indexX,indexY)+1; 
    end
    
    % Calculating accuracy
    conf = trace(confusion)/sum(sum(confusion));
    
    % Saving the confusion matrix and accuracy to confusion.mat
    save('confusion.mat', 'confusion', 'conf');
end
