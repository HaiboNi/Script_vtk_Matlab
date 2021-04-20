% Author: Haibo Ni <haibo.ni0822@gmail.com>
% Author: Shanzhuo Zhang <shanzhuo.zhang@gmail.com>

% This Script reads image files and write into VTK
% Downsample is used in default.

% To use the script, please copy the image folder "Processed_Raw/" to the current folder.


% This script was created under the terms of the GNU General Public License 
% See the GNU General Public License for more details (www.gnu.org/licenses)
% The script is distributed in the hope that it will be useful but WITHOUT 
% ANY WARRANTY; 

files = {'01____z0.0.jpg'
    '02____z1.0.jpg'
    '03____z2.0.jpg'
    '04____z3.0.jpg'
    '05____z4.0.jpg'
    '06____z5.0.jpg'
    '07____z6.0.jpg'
    '08____z7.0.jpg'
    '09____z8.0.jpg'
    '10____z9.0.jpg'
    '11____z10.0.jpg'
    '12____z11.0.jpg'
    '13____z12.0.jpg'
    '14____z13.0.jpg'
    '15____z14.0.jpg'
    '16____z15.0.jpg'
    '17____z16.0.jpg'
    '18____z17.0.jpg'
    '19____z18.0.jpg'
    '20____z19.0.jpg'
    '21____z20.0.jpg'
    '22____z21.0.jpg'
    '23____z22.0.jpg'
    '24____z23.0.jpg'
    '25____z24.0.jpg'
    '26____z25.0.jpg'
    '27____z26.0.jpg'
    '28____z27.0.jpg'
    '29____z28.0.jpg'
    '30____z29.0.jpg'
    '31____z30.0.jpg'
    '32____z31.0.jpg'
    '33____z32.0.jpg'
    '34____z33.0.jpg'
    '35____z34.0.jpg'
    '36____z35.0.jpg'
    '37____z36.0.jpg'
    '38____z37.0.jpg'
    '39____z38.0.jpg'
    '40____z39.0.jpg'
    '41____z40.0.jpg'
    '42____z41.0.jpg'
    '43____z42.0.jpg'
    '44____z43.0.jpg'
    '45____z44.0.jpg'
    '46____z45.0.jpg'
    '47____z46.0.jpg'
    '48____z47.0.jpg'
    };


downsample_bool = 1;  % Flag for whether doing the downsampling

%% Read one of the figures to get its dimentions
filename = files{1};
filename = strcat ('Processed_Images/', filename);  % could used Process_Clean
fprintf('Reading image = %s\n',filename);
fprintf('processing image = %s\n',filename);

image_ori = imread(filename);
G_ori = (image_ori(:,:,1));

if downsample_bool == 1  % Downsampling will change the dimentions
    G_ori =  down_sample (G_ori);
    G_ori =  down_sample (G_ori);
end

[Y, X] = size(G_ori); % Get the dimentions of figures


%% Iterate all figures to fill the 3D volume
volume = zeros(Y,X,length(files));
for i = 1:48
    
    % index = index_array(i);
    filename = files{i};
    filename = strcat ('Processed_Images/', filename);
    fprintf('Reading image = %s\n',filename);
    image_ori = imread(filename);
    % G_ori = (image_ori(:,:,2));
    G_ori= image_ori;
    if downsample_bool == 1
        G_ori =  down_sample (G_ori);  % note, could apply Gaussian Filter to remove noises, not implemented here. 
        G_ori =  down_sample (G_ori);
    end
    volume(:,:,i) = G_ori;
end

volume=volume(60:620,80:945,:);  % Crop the volume to remove empty space
volume = RegionGrow3d(volume, [0,0,0], 2);  % Apply RegionGrow to remove noises outside the tissue. 
write_scalar_vtk(volume, '3D_reconstruction')


clear; 