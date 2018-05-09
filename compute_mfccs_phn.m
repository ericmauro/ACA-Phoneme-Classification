function [mfccs,d_mfccs,dd_mfccs] = compute_mfccs_phn(x_phn,filtbank,nfft,n_dct)
% Parameters
% ----------
% x_phn : 1 x N array
%   contains training data and labels, train.data and train.label
% filterbank :  num_mel_filts x (nfft/2)+1 array
%   matrix filterbank of triangular bandpass filters
% nfft : int
%   Classifier model. Either 'knn', 'svm', or 'rf'
% n_dct : int
%   number of DCT coefficients
%
% Returns
% -------
% mfccs : n_dct-1 x NT array
%   MFCC matrix (NT is number spectrogram frames)
% d_mfccs: n_dct-1 x NT array
%   Delta MFCC matrix (NT is number spectrogram frames)
% dd_mfccs: n_dct-1 x NT array
%   Delta Delta MFCC matrix (NT is number spectrogram frames)

% Calculating the power of the spectrum
    X = abs(fft(x_phn,nfft));
    P = (abs(X).^2)/nfft;

    % Removing the redundant portion of the spectrum
    P = P(1: (end/2) + 1, :);
    
    % Compute Mel power spectrum
    log_energy = log(filtbank*P);

    % DCT
    ccs = dct(log_energy);
    mfccs = ccs(1:n_dct, :);
    mfccs(1,:) = []; % remove DC component
    
    N = size(mfccs,2);
    if N == 1
        d_mfccs = zeros(n_dct-1,1);
        dd_mfccs = zeros(n_dct-1,1);
    elseif N == 2
        I = speye(N);
        D = I(2:N, :) - I(1:N-1, :);
        d_mfccs = mfccs*D';
        dd_mfccs = zeros(n_dct-1,1);
    else
        I1 = speye(N);
        I2 = speye(N-1);
        D1 = I1(2:N, :) - I1(1:N-1, :);
        D2 = I2(2:N-1,:) - I2(1:N-2,:);
        d_mfccs = mfccs*D1';
        dd_mfccs = d_mfccs*D2';
    end
end

