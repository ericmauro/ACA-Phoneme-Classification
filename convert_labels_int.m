% Eric Mauro & Robert Schwartzberg
% ACA Final Project: Phoneme recognition
clear all; close all; clc;

%% Load MFCC data
train = load('phn_train_scaled.mat','label','data');
test = load('phn_test_scaled.mat','label','data');
train_size = 177080;
test_size = 64145;

%% List phonemes
class{1} = {'aa', 'ae', 'ah', 'ao', 'aw', 'ax-h', 'ax',...
            'axr', 'ay', 'b', 'bcl', 'ch', 'd', 'dcl', 'dh', ...
            'dx', 'eh', 'el', 'em', 'en', 'eng', 'epi', 'er', 'ey', ...
            'f', 'g', 'gcl', 'h#', 'hh', 'hv', 'ih', 'ix', 'iy',...
            'jh', 'k', 'kcl', 'l', 'm', 'n', 'ng', 'nx', 'ow', 'oy', ...
            'p', 'pau', 'pcl', 'q', 'r', 's', 'sh', 't', 'tcl', 'th', ...
            'uh', 'uw', 'ux', 'v', 'w', 'y', 'z', 'zh'};
        
class{2} = {'VS','NF','SF','WF','ST','CL'};
class{3} = {'SON', 'OBS', 'SIL'};
class{4} = {'Vowels', 'Stops', 'Fricatives', 'Nasals', 'Silences'};

%% Convert labels
gen_train_label{1} = generalize_labels(train.label,'n');
gen_train_label{2} = generalize_labels(train.label,'h');
gen_train_label{3} = generalize_labels(train.label,'H');
gen_train_label{4} = generalize_labels(train.label,'s');
gen_test_label{1} = generalize_labels(test.label,'n');
gen_test_label{2} = generalize_labels(test.label,'h');
gen_test_label{3} = generalize_labels(test.label,'H');
gen_test_label{4} = generalize_labels(test.label,'s');

%% Str to int array
for j = 1:4
    train_label_int = zeros(1,train_size);
    test_label_int = zeros(1,test_size);
    for i = 1:length(class{j})
        train_label_int = train_label_int + i.*strcmp(class{j}{i},gen_train_label{j});
        test_label_int = test_label_int + i.*strcmp(class{j}{i},gen_test_label{j});
    end
    train_label{j} = train_label_int;
    test_label{j} = test_label_int;
end

%% Save to mat file
save('phn_train_int_label.mat','train_label')
save('phn_test_int_label.mat','test_label')
