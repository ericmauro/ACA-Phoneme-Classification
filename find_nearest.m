function [nearest_indices] = find_nearest(reference, target)
%    Find indices of nearest values in a reference array to a target array.
%
%    Example:
%    > reference = [0, 3, 7, 9, 10, 15, 16, 17]';
%    > target = [1, 10, -2, 20];
%    > find_nearest(reference, target)
%      [1, 5, 1, 8]
%
%    Parameters
%    ----------
%    reference : R x 1 array
%        Array of reference values.
%    target : 1 x T array
%        Array of target values.
%
%    Returns
%    -------
%    nearest_indices : 1 x T array
%        Indices of reference values that are nearest to values of target.

    L_target = length(target);
    L_reference = length(reference);
    diff_matrix = repmat(reference,1,L_target) - repmat(target,L_reference,1);
    [~,nearest_indices] = min(abs(diff_matrix));

end