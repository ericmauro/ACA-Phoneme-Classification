function [filterbank] = create_filtbank(min_freq,max_freq,fs,...
    nfft,num_mel_filts)
% Parameters
% ----------
% min_freq : float
%   minimum frequency in Mel filterbank (Hz)
% max_freq : float
%   maximum frequency in Mel filterbank (Hz)
% fs : int
%   sampling frequency
% nfft : int
%   fft length
% num_mel_filts: int
%   number of Mel filters
%
% Returns
% -------
% filterbank :  num_mel_filts x (nfft/2)+1 array
%   matrix filterbank of triangular bandpass filters

nfft2 = nfft/2+1; % Relevant info in fft

% Generating the Mel filterbank
min_mel = hz2mel(min_freq);
max_mel = hz2mel(max_freq);
mel_values = linspace(min_mel, max_mel, num_mel_filts + 2);
freq_values = mel2hz(mel_values);
freq_bins = floor((nfft+1) * freq_values / fs);
filterbank = zeros(nfft2, num_mel_filts);
for m = 1:length(filterbank(1, :))
    for k = 1:length(filterbank(:, 1))
        if (freq_bins(m) <= k && k <= freq_bins(m + 1))
            filterbank(k, m) = (k - freq_bins(m)) / (freq_bins(m + 1) - freq_bins(m));
        elseif (freq_bins(m + 1) <= k && k <= freq_bins(m + 2))
            filterbank(k, m) = (freq_bins(m + 2) - k) / (freq_bins(m + 2) - freq_bins(m + 1));
        end
    end
end

% Normalizing the filters
for i = 1:length(filterbank(1, :))
    filterbank(:, i) = filterbank(:, i) .* (1 / sum(filterbank(:, i)));
end

filterbank = filterbank';
end

