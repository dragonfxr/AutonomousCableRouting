function [pattern] = GetColourCode(image, column, cores)
% Description: Receives an image of an electrical cable and working axis
% to determine the pattern of the coloured core insulations. This version
% assumes that the image has been rotated until the cable if horizontal and
% a column of coloured cores has been specified. This is to imitate the
% type of accuracy that would been observed in an industrial process
% Inputs:  image - RGB image matrix
%          column - the column number to get the colour pattern from
%          cores - number of cores in cable
% Outputs: pattern - array of colour characters, top-to-bottom (b = blue /
%                    g = grey / k = black / n = brown / y = yellow-green)
% NOTE: 3-core and 4-core cables have "bny" and "gkny" colours respectively
% Author: Zach Macleod

%% Initialisation
% Set colour boundaries (in HSV colour model)
% b(x) = (lower limit for hue, upper limit for hue;
%                 lower limit for saturation, upper limit for saturation;
%                 lower limit for value, upper limit for value)
b = zeros(5, 3, 2);
b(1, :, :) = [0.56, 0.7; 0.5, 1; 0.2, 0.7]; % Blue
b(2, :, :) = [0, 1; 0, 0.03; 0.2, 0.4]; % Grey
b(3, :, :) = [0, 1; 0, 1; 0, 0.2]; % Black
b(4, :, :) = [0.6501, 0.8; 0.1, 0.5; 0.15, 0.6]; % Brown - Dependent on
% light conditions
%b(4, :, :) = [0.6501, 1.08; 0.1, 0.5; 0.15, 0.6]; % Brown - Dependent on
% light conditions
b(5, :, :) = [0.08, 0.55; 0.3, 1; 0.3, 0.8]; % Yellow-Green

% Initialise the coloured pixel and cumulative row count
pixels = zeros(1, 5);
n = zeros(1, 5);

% Initialising size of image
[rows, ~, ~] = size(image);

%% Processing
% Convert image to HSV colour model
image = rgb2hsv(image);

% For each pixel, check if it fits inside the boundaries of each colour. If
% so, add to the pixel count and the cumulative row count of that
% colour. If the upper limit of hue is above 1, add 1 to the pixel hue
% (HSV colour model uses a cylcic hue so 0 and 1 are the same - red).
for r = 1:rows
    for c = column-1:column+1
        for a = 1:5
            if ((b(a, 1, 2) >= 1) + image(r, c, 1) >= b(a, 1, 1) && (b(a, 1, 2) >= 1) + image(r, c, 1) <= b(a, 1, 2)) && image(r, c, 2) >= b(a, 2, 1) && image(r, c, 2) <= b(a, 2, 2) && image(r, c, 3) >= b(a, 3, 1) && image(r, c, 3) <= b(a, 3, 2)
                n(a) = n(a) + r;
                pixels(a) = pixels(a) + 1;
            end
        end
    end
end

%% Output
% Take the relevant colours for 3/4 cores
if cores == 3
    n = n([1, 4, 5]);
    pixels = pixels([1, 4, 5]);
    pattern = 'bny';
elseif cores == 4
    n = n([2, 3, 4, 5]);
    pixels = pixels([2, 3, 4, 5]);
    pattern = 'gkny';
end

% Divide each colour's cumulative row by it's pixel count to find
% the mean row
n = n ./ pixels;


% Sort in ascending order
[n, order] = sort(n);

% Rearrange pattern for output
pattern = pattern(order);

%% Show Image
% Convert the image back to the RGB colour model
image = hsv2rgb(image);

% Add the working column as a line of red
image(:, column - 2: column + 2, 1) = 1;
image(:, column - 2: column + 2, 2) = 0;
image(:, column - 2: column + 2, 3) = 0;

disp(n);

% Add the mean rows to the image as relevant colours
for k = 1:length(pattern)
    try
        if pattern(k) == 'b'
            image(ceil(n(k))-1:ceil(n(k))+1, :, 1) = 0;
            image(ceil(n(k))-1:ceil(n(k))+1, :, 2) = 0;
            image(ceil(n(k))-1:ceil(n(k))+1, :, 3) = 1;
        elseif pattern(k) == 'g'
            image(ceil(n(k))-1:ceil(n(k))+1, :, 1) = 0.3;
            image(ceil(n(k))-1:ceil(n(k))+1, :, 2) = 0.3;
            image(ceil(n(k))-1:ceil(n(k))+1, :, 3) = 0.3;
        elseif pattern(k) == 'k'
            image(ceil(n(k))-1:ceil(n(k))+1, :, 1) = 0;
            image(ceil(n(k))-1:ceil(n(k))+1, :, 2) = 0;
            image(ceil(n(k))-1:ceil(n(k))+1, :, 3) = 0;
        elseif pattern(k) == 'n'
            image(ceil(n(k))-1:ceil(n(k))+1, :, 1) = 0.5;
            image(ceil(n(k))-1:ceil(n(k))+1, :, 2) = 0.2;
            image(ceil(n(k))-1:ceil(n(k))+1, :, 3) = 0.2;
        elseif pattern(k) == 'y'
            image(ceil(n(k))-1:ceil(n(k))+1, :, 1) = 1;
            image(ceil(n(k))-1:ceil(n(k))+1, :, 2) = 1;
            image(ceil(n(k))-1:ceil(n(k))+1, :, 3) = 0;
        end
    catch
        disp(['No pixels of colour ''', pattern(k), ''' were found']);
    end
end

% Show image
imshow(image);

imwrite(image, 'processed.jpg');
