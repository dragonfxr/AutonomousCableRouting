function [n] = PushRollerBearingCount(cable_r, axle_d, bearing_w)
% Finds the number of bearings needed for the push roller considering the
% radius of the cable to be layed, the horizontal distance between the
% two axles, and the width of the bearings. Use consistent units.

% Find the min radius of the channel curve
curve_r = 16 * cable_r;

% Find the number of bearings reuired
n = 2 / bearing_w * (curve_r - sqrt(curve_r ^ 2 - axle_d ^ 2));

% Round number up
n = ceil(n);

end