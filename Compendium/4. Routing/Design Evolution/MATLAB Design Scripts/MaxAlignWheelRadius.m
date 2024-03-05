function [R_max] = MaxAlignWheelRadius(cable_r, press_depth, press_ratio)
% Finds the max radius of the drive wheel considering the radius of the
% cable to be layed, the min depth that
% the cable is to be pushed in (from middle of cable) and the min ratio of the
% total cable press force which is pushing the cable down. Use consistent
% units.

% Find the min radius of the channel curve
curve_r = 16 * cable_r;

% Find the max angle for press ratio
press_angle = acos(press_ratio);

% Find the max deivation from press angle
centre_deviation = tan(press_angle) * (cable_r - press_depth);

% Find the max half-length of cable pushed in by wheel at once which can
% fit within deviation
l = sqrt(curve_r ^ 2 - (curve_r - centre_deviation) ^ 2);

% Find the max radius from half_length
R_max = ((press_depth - cable_r) ^ 2 + l ^ 2) / (2 * (cable_r - press_depth));

end