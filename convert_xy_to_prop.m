% converts an x y to the nearest proportion along track
% l length of stadium
% r radius of stadium
% x x position to be converted
% y y position to be converted
% prop proportion along border from top left corner
function prop = convert_xy_to_prop(l, r, x, y)
    totalDist = getStadiumBorderDistance(l,r);
    % if the x is in the infinite vertical slice of rectangle, we will
    % say it is closest to one of the lines.
    if ( x <= l/2 && x >= -l/2)
        % if y is greater than zero, we will say it is closest to top line
        if (y > 0 )
            prop = (x + l/2)/totalDist;
        else % bottom line
            prop = ((l + r * pi) + (l/2 - x))/totalDist;
        end
        
    elseif (x > l/2) % right semicircle
        angle = atan2((x - l/2), y);
        prop = (l + r * angle )/totalDist;
        
    else % left semicircle
        angle = atan2(-(x + l/2), -y)
        prop = ((2 * l + r * pi) + r * angle)/totalDist;
    end
end