% Eric Mauro & Robert Schwartzberg
% ACA Final Project: Phoneme recognition
% Training and classification
clear all; close all; clc;

%% Load MFCC data and set label mode
train = load('phn_train_scaled.mat','label','data');
test = load('phn_test_scaled.mat','label','data');
mode = 'n'; % Label grouping mode, 'h', 'H', or 's', else normal
type = 'rf'; % Classifier type, 'knn', 'svm', or 'rf'
rng(1); % For reproducibility 

%% Define random sample set size of training and test data
train_size = 20000;
test_size = 10000;

%% Create classifier and predict labels
[test_label,predicted_label] = phn_classify(train,test,...
    train_size,test_size,type,mode);

%% Compute overall accuracy and confusion matrix
accuracy = sum(strcmp(predicted_label,test_label))/length(predicted_label);

[C,order] = confusionmat(test_label,predicted_label);
C = C./sum(C,2); % Normalize by row sums, ie. total actual samples
imagesc(C);
xticks([1:length(unique(test_label))])
yticks([1:length(unique(test_label))])
xticklabels(order)
yticklabels(order)
xlabel('Predicted Label')
ylabel('Actual Label')
colorbar;