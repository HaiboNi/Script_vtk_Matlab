% Author: Haibo Ni <haibo.ni0822@gmail.com>
% Author: Shanzhuo Zhang <shanzhuo.zhang@gmail.com>

% This script was created under the terms of the GNU General Public License 
% See the GNU General Public License for more details (www.gnu.org/licenses)
% The script is distributed in the hope that it will be useful but WITHOUT 
% ANY WARRANTY; 

function write_scalar_vtk(newV, filename)
% Input: newV - Image volume to write
%        filename - filename to write into.
% Output: N/A
tic

[m,n,o]=size(newV);

filename = strcat( filename, '.vtk' ) ;
fid = fopen( filename, 'W+');

%% Write a header defined by vtk
fprintf(fid,'# vtk DataFile Version 3.0\n');
fprintf(fid,'vtk output\n');
fprintf(fid,'BINARY\n');
fprintf(fid,'DATASET STRUCTURED_POINTS\n');
% fprintf(fid,'DIMENSIONS %i %i %i\n', n, m, o);

fprintf(fid,'DIMENSIONS %i %i %i\n',m, n, o);
fprintf(fid,'SPACING 0.010304 0.010304 0.05177\n');  % spatial resolution
fprintf(fid,'ORIGIN 0 0 0\n');
fprintf(fid,'POINT_DATA %i\n',m*n*o);
fprintf(fid,'SCALARS ImageFile float\n');
fprintf(fid,'LOOKUP_TABLE default\n');
fclose(fid);

%% Write bytes of the volume
fid = fopen( filename, 'ab');
fwrite(fid,reshape(newV,1,n*m*o),'float','b');
fclose(fid);

disp( strcat(filename, ' SCALAR volume writing done!') );
toc
end % end of the script