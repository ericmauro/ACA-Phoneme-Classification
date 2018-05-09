% Eric Mauro & Robert Schwartzberg
% ACA Final Project: Phoneme recognition
% MFCC data processing
clear all; close all; clc;

%% Parameters
min_freq=50;
max_freq=7000;
num_mel_filts=40;
n_dct=13;
nfft = 8192;
fs = 16000;
win_size = 256;
hop_size = 128;

% Create filter bank
filtbank = create_filtbank(min_freq,max_freq,fs,nfft,num_mel_filts);

%% Retrieve and separate phoneme audio data
dataset = 'test'; % train or test

train_size = 177080;
test_size = 64145;
if strcmp('train',dataset)
    folder = fullfile('timit','TIMIT','TRAIN');
    size = train_size;
else
    folder = fullfile('timit','TIMIT','TEST');
    size = test_size;
end
x = dir(folder);
it = 1; % Iterations to track progress
dr_range = 1; % For tracking where dialect regions change in data set
data = zeros(6*(n_dct-1),size);
tic
for i = 3:length(x) % Dialect region (DR#)
    y = dir(fullfile(folder,x(i).name));
    for j = 3:length(y) % Speaker ID
        z = dir(fullfile(folder,x(i).name,y(j).name,'*.wav'));
        for k = 1:length(z) % Sentence text
            file = fullfile(folder,x(i).name,y(j).name,z(k).name);
            [x_t,fs,phn] = readsph(file,'t');
            for l=1:length(phn(:,1))
                [win_sec label{it}] = phn{l,:};
                win_samp = round(win_sec.*fs);
                x_phn = x_t(win_samp(1)+1:win_samp(2));
                x_win = buffer(x_phn,win_size,win_size-hop_size);
                x_win = x_win.* hamming(win_size);
                [mfccs,d_mfccs,dd_mfccs] = compute_mfccs_phn(x_win,filtbank,nfft,n_dct);
                data(:,it) = [mean(mfccs,2); std(mfccs,0,2); ...
                              mean(d_mfccs,2); std(d_mfccs,0,2); ...
                              mean(dd_mfccs,2); std(dd_mfccs,0,2)];
                it = it+1;
            end
        end
        disp([num2str(100*(it/size)),'%']);
        toc
    end
    dr_range = [dr_range; it];
end

%% Scale and save data
data = (data-mean(data,2))./std(data,0,2);
if strcmp('train',dataset)
    save('phn_train_scaled.mat','label','data')
else
    save('phn_test_scaled.mat','label','data')
end