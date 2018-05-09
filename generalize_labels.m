function general_labels = generalize_labels(specific_labels, mode)
% specific_labels is a 1xN cell of phoneme labels 
%    (ie. 'aa', 'ae', 'ah', ...)
% mode denotes the classifier system to use (taken from the research paper)
%   mode = 'h' refers to Table 4 (top) (Halberstadt, 1998) (has 6 classes)
%   mode = 'H' refers to Table 4 (bottom) (Halberstadt, 1998) (has 3 classes)
%   mode = 's' refers to Table 6 (Scanlon et al., 2007) (has 5 classes)
%
% general_labels is a 1xN cell of phoneme group labels (depends on the mode)

numLabels = length(specific_labels);

general_labels = cell(1, numLabels);
if strcmp(mode, 'h')
    h1 = {'aa', 'ae', 'ah', 'ao', 'aw', 'ax', 'axh', 'axr', 'ay', 'eh', ...
        'er', 'ey', 'ih', 'ix', 'iy', 'ow', 'oy', 'uh', 'uw', 'ux', ...
        'el', 'l', 'r', 'w', 'y'};
    h2 = {'em', 'en', 'eng', 'm', 'n', 'ng', 'nx', 'dx'};
    h3 = {'s', 'z', 'sh', 'zh', 'ch', 'jh'};
    h4 = {'v', 'f', 'dh', 'th', 'hh', 'hv'};
    h5 = {'b', 'd', 'g', 'p', 't', 'k'};
    for i = 1:numLabels
        phn = specific_labels{1, i};
        if any(strcmp(h1,phn))
            general_labels{1, i} = 'VS';
        elseif any(strcmp(h2,phn))
            general_labels{1, i} = 'NF';
        elseif any(strcmp(h3,phn))
            general_labels{1, i} = 'SF';
        elseif any(strcmp(h4,phn))
            general_labels{1, i} = 'WF';
        elseif any(strcmp(h5,phn))
            general_labels{1, i} = 'ST';
        else
            general_labels{1, i} = 'CL';
        end
    end
elseif strcmp(mode, 'H')
    H1 = {'aa', 'ae', 'ah', 'ao', 'aw', 'ax', 'axh', 'axr', 'ay', 'eh', ...
        'er', 'ey', 'ih', 'ix', 'iy', 'ow', 'oy', 'uh', 'uw', 'ux', 'el', ...
        'l', 'r', 'w', 'y', 'em', 'en', 'eng', 'm', 'n', 'ng', 'nx', 'dx'};
    H2 = {'s', 'z', 'sh', 'zh', 'ch', 'jh', 'v', 'f', 'dh', 'th', 'hh', ...
        'hv', 'b', 'd', 'g', 'p', 't', 'k'};
    for i = 1:numLabels
        phn = specific_labels{1, i};
        if any(strcmp(H1,phn))
            general_labels{1, i} = 'SON';
        elseif any(strcmp(H2,phn))
            general_labels{1, i} = 'OBS';
        else
            general_labels{1, i} = 'SIL';
        end
    end
elseif strcmp(mode, 's')
    s1 = {'aa', 'ae', 'ah', 'ao', 'ax', 'ax-h', 'axr', 'ay', 'aw', 'eh', ...
        'el', 'er', 'ey', 'ih', 'ix', 'iy', 'l', 'ow', 'oy', 'r', 'uh', ...
        'uw', 'ux', 'w', 'y'};
    s2 = {'p', 't', 'k', 'b', 'd', 'g', 'jh', 'ch'};
    s3 = {'s', 'sh', 'z', 'zh', 'f', 'th', 'v', 'dh', 'hh', 'hv'};
    s4 = {'m', 'em', 'n', 'nx', 'ng', 'eng', 'en'};
    for i = 1:numLabels
        phn = specific_labels{1, i};
        if any(strcmp(s1,phn))
            general_labels{1, i} = 'Vowels';
        elseif any(strcmp(s2,phn))
            general_labels{1, i} = 'Stops';
        elseif any(strcmp(s3,phn))
            general_labels{1, i} = 'Fricatives';
        elseif any(strcmp(s4,phn))
            general_labels{1, i} = 'Nasals';
        else
            general_labels{1, i} = 'Silences';
        end
    end
else
    general_labels = specific_labels;
end

end