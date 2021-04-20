% Author: Haibo Ni <haibo.ni0822@gmail.com>
% Author: Shanzhuo Zhang <shanzhuo.zhang@gmail.com>

% This script was created under the terms of the GNU General Public License 
% See the GNU General Public License for more details (www.gnu.org/licenses)
% The script is distributed in the hope that it will be useful but WITHOUT 
% ANY WARRANTY; 

function [Im3] = down_sample (Im)
% Input: Im - Image slice to be downsampled, and 
% Output: Im3 - down sampled slice




Dim = length(size(Im));  % check the dimension
if (Dim == 2)
    [Y, X] = size(Im);
    if (rem(X,2) == 0)
        X2 = X/2;
    else
        X2 = (X-1)/2;
    end
    if (rem(Y,2) == 0)
        Y2 = Y/2;
    else
        Y2 = (Y-1)/2;
    end
    
    
    for x=1:X2
        for y=1:Y2
            Im3(y,x) = Im(2*y, 2*x);
        end
    end
else 
	fprintf('Dim is %i\n', Dim);
	error('Dim 2 is expected');
end
end % end of the script