% converts a proportion to x and y position
% l length of stadium
% r radius of stadium
% prop proportion along border from top left corner
function [X Y] = convert_prop_to_xy(l, r, prop)
    Cutoffs = corner_cutoffs(l, r);
    if (prop <= Cutoffs(1)) % on top straight line
        propOnSegment = prop/Cutoffs(1);
        X = propOnSegment * l - l/2;
        Y = r;
    elseif (prop <= Cutoffs(2)) % on right semicircle
        propOnSegment = (prop - Cutoffs(1))/(Cutoffs(2) - Cutoffs(1));
        angle = pi/2 - propOnSegment * pi; % go from top around to bottom
        X = r * cos(angle) + l/2;
        Y = r * sin(angle);
    elseif (prop <= Cutoffs(3)) % on bottom line
        propOnSegment = (prop - Cutoffs(2))/(Cutoffs(3) - Cutoffs(2));
        X = l/2 - propOnSegment * l;
        Y = -r;
    else % assume on left semicircle
        propOnSegment = (prop - Cutoffs(3))/(Cutoffs(4) - Cutoffs(3));
        angle = 3 * pi/2 - propOnSegment * pi; % go from bottom around to top
        X = r * cos(angle) - l/2; 
        Y = r * sin(angle);
    end
end


% returns the cutoffs for the corners
% used to tell when line turns to semicircle
function Cutoffs = corner_cutoffs(l , r)
    totalBorder = getStadiumBorderDistance(l,r);
    Cutoffs = [l, l + pi * r, 2 * l + pi * r, totalBorder] ./totalBorder;
end