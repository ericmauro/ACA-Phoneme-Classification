function [test_label,predicted_label] = phn_classify(train,test,...
    train_size,test_size,type,mode)
% Create classifier model and predict test data labels
% Parameters
% ----------
% train : struct
%   contains training data and labels, train.data and train.label
% test : struct
%   contains test data and labels, test.data and test.label
% type : string
%   Classifier model. Either 'knn', 'svm', or 'rf'
% mode : string
%   Labeling mode. Either 'h', 'H', or 's'
%
% Returns
% -------
% test_label : 1 x L cell array
%   array of test data labels of specified length L
% predicted_label: 1 x L cell array
%   array of predicted test data labels of specified length L

% Create random sample sets
train_ind = randsample(177080,train_size);
test_ind = randsample(64145,test_size);

% Create classifier model
if strcmp(type,'knn')
    t = templateKNN();
    train_labels = generalize_labels(train.label(train_ind),mode);
    Mdl = fitcecoc(train.data(:,train_ind)',train_labels,...
        'Learners',t);
elseif strcmp(type,'svm')
    t = templateSVM();
    train_labels = generalize_labels(train.label(train_ind),mode);
    Mdl = fitcecoc(train.data(:,train_ind)',train_labels,...
        'Learners',t);
elseif strcmp(type,'rf')
    numTrees = 150;
    train_labels = generalize_labels(train.label(train_ind),mode);
    Mdl = TreeBagger(numTrees, train.data(:,train_ind)',train_labels);
else
    disp('Model type not understood')
    return
end

% Predict labels for test set
predicted_label = predict(Mdl,test.data(:,test_ind)');
test_label = generalize_labels(test.label(test_ind),mode)';
end

