% Author: Haibo Ni <haibo.ni0822@gmail.com>
% Author: Shanzhuo Zhang <shanzhuo.zhang@gmail.com>

% This script was created under the terms of the GNU General Public License 
% See the GNU General Public License for more details (www.gnu.org/licenses)
% The script is distributed in the hope that it will be useful but WITHOUT 
% ANY WARRANTY; 

function [ Im2 ] = RegionGrow3d( Im, StartPoint, Threshold )
%REGIONGROW Performs a reqion growing method on an image.
%   Im - input image volume 
%   StartPoint - Matrix index (in [x, y, z]) to start with
%   Threshold connected to the point of highest intensity of input image
%   Im2 - Output resulting image volume data

tic
Im2 = Im;
[Y, X, Z] = size(Im2);
done = zeros(Y,X,Z);

if min(StartPoint) <=0
    x(1) = round(X/2);
    y(1) = round(Y/2);
    z(1) = round(Z/2);
else
    x(1) = StartPoint(1);
    y(1) = StartPoint(2);
    z(1) = StartPoint(3);
end

% [x y z ]
going=1;

N = [1 0 0; -1 0 0; 0 1 0; 0 -1 0; 0 0 1; 0 0 -1];
m = 0;
n = length(x);
while (going == 1)
    trap = 0;
    last_n = m;
    n = length(x);
    m = n;
     
    for i = last_n+1 : m
        for j = 1:6
            x2 = x(i) + N(j,1);
            y2 = y(i) + N(j,2);
            z2 = z(i) + N(j,3);
            if (x2>0 && x2<=X && y2>0 && y2<=Y && z2>0 && z2<=Z && done(y2, x2, z2) == 0 )
                trap = 1;
                if (Im2(y2, x2, z2) > Threshold)
                    done(y2, x2, z2) = 1;
                    
                    x(n+1) = x2;
                    y(n+1) = y2;
                    z(n+1) = z2;
                    n = length(x);
                else
                    Im2(y2, x2, z2) = 0;
                    done(y2, x2, z2) = 1;
                end
            end
        end
    end
    if (trap == 0)
        going = 0;
    end
end
disp(n);
for z=1:Z
    for y=1:Y
        for x=1:X
            if (done(y,x,z) == 0)
                Im2(y,x,z) = 0;
            end
        end
    end
end

toc
end
