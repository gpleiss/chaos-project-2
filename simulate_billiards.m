% simulates a billiards run on the stadium
% @params:
%   l length of stadium
%   r radius of stadium
%   startProportion fraction of border that is the starting position from
%       top left corner
%   velDir direction of travel from east in range of 0-2*pi
function simulate_billiards(l, r, startProportion, velDir, n)
    clc;
    close all;

    Pos = convert_prop_to_xy(l, r, startProportion);
    draw_stadium(l,r);
    hold on
    x = Pos(1); y = Pos(2);
    plot(x, y, 'r.');
    for i = 1:n
        xold = x; yold = y;
        plot(xold, yold, 'r.');
        [x, y, velDir] = getNextHitPoint(l, r, x, y, velDir);
        plot(x, y, '.');
        plot([xold, x], [yold, y]);
        fprintf('iter: %d    X: %.2f    Y: %.2f\n', i, x, y);
        drawnow;
        pause(.1);
    end
end

% converts a proportion to x and y position
% l length of stadium
% r radius of stadium
% prop proportion along border from top left corner
function Pos = convert_prop_to_xy(l, r, prop)
    Cutoffs = corner_cutoffs(l, r);
    if (prop <= Cutoffs(1)) % on top straight line
        propOnSegment = prop/Cutoffs(1);
        Pos = [propOnSegment * l - l/2, r];
    elseif (prop <= Cutoffs(2)) % on right semicircle
        propOnSegment = (prop - Cutoffs(1))/(Cutoffs(2) - Cutoffs(1));
        angle = pi/2 - propOnSegment * pi; % go from top around to bottom
        Pos = [r * cos(angle) + l/2, r * sin(angle)];
    elseif (prop <= Cutoffs(3)) % on bottom line
        propOnSegment = (prop - Cutoffs(2))/(Cutoffs(3) - Cutoffs(2));
        Pos = [l/2 - propOnSegment * l, -r];
    else % assume on left semicircle
        propOnSegment = (prop - Cutoffs(3))/(Cutoffs(4) - Cutoffs(3));
        angle = 3 * pi/2 - propOnSegment * pi; % go from bottom around to top
        Pos = [ r * cos(angle) - l/2, r * sin(angle)];
    end

end

% returns the cutoffs for the corners
% used to tell when line turns to semicircle
function Cutoffs = corner_cutoffs(l , r)
    totalBorder = 2 * l + 2 * pi * r;
    Cutoffs = [l, l + pi * r, 2 * l + pi * r, totalBorder] ./totalBorder;
end

% returns the position of the next point that this ball will hit
function [xnew, ynew, newVelDir] = getNextHitPoint(l, r, xold, yold, velDir)
    % see x intersection with top line. new point will be (xnew, r)
    xnew = (r - yold)/tan(velDir) + xold;
    ynew = r;
    % if not same point and in line segment
    if ( (xold ~= xnew || yold ~= ynew) && (xnew <= l/2 && xnew >= - l/2) )
        newVelDir = mod(pi - velDir, 2 * pi);
        return;
    end
    
    % see x intersection with bottom line. new point will be (xnew, -r)
    xnew = (-r - yold)/tan(velDir) + xold;
    ynew = -r;
    % if not same point and in line segment
    if ( (xold ~= xnew || yold ~= ynew) && (xnew <= l/2 && xnew >= - l/2) )
        newVelDir = mod(pi - velDir, 2 * pi);
        return;
    end
    
    % right semicircle
    dx = cos(velDir);
    dy = sin(velDir);
    D = (xold - l/2) * (yold + dy) - (xold - l/2 + dx) * (yold);
    discriminant = r^2 - D^2;
    if (discriminant >=0)
        xnew = D * dy + sign(dy) * dx * sqrt(discriminant);
        ynew = -D * dx + abs(dy) * sqrt(discriminant);
        if (xnew > 0 && (xold ~= xnew + l/2|| yold ~= ynew))
            % need to reflect over xnew, ynew normal direction
            newVelDir = (2 * atan2(ynew, xnew) - velDir);
            %newVel = ref_mat(atan2(ynew, xnew)) * [dx;dy];
            %newVelDir = atan2(newVel(2), newVel(1));
            xnew = xnew + l/2;
            return;
        else
            xnew = D * dy - sign(dy) * dx * sqrt(discriminant);
            ynew = -D * dx - abs(dy) * sqrt(discriminant);
            if (xnew > 0 && (xold ~= xnew + l/2|| yold ~= ynew))
                % need to reflect over xnew, ynew normal direction
                newVelDir = (2 * atan2(ynew, xnew) - velDir);
                xnew = xnew + l/2;
                return;
            end
            
        end
    end
    
    % now left semicircle
    D = (xold + l/2) * (yold + dy) - (xold + l/2 + dx) * (yold);
    discriminant = r^2 - D^2;
    if (discriminant >=0)
        xnew = D * dy + sign(dy) * dx * sqrt(discriminant);
        ynew = -D * dx + abs(dy) * sqrt(discriminant);
        if (xnew < 0 && (xold ~= xnew - l/2|| yold ~= ynew))
            % need to reflect over xnew, ynew normal direction
            newVelDir = (2 * atan2(ynew, xnew) - velDir);
            xnew = xnew - l/2;
            return;
        else
            xnew = D * dy - sign(dy) * dx * sqrt(discriminant);
            ynew = -D * dx - abs(dy) * sqrt(discriminant);
            if (xnew < 0 && (xold ~= xnew - l/2|| yold ~= ynew))
                % need to reflect over xnew, ynew normal direction
                newVelDir = (2 * atan2(ynew, xnew) - velDir);
                xnew = xnew - l/2;
                return;
            end
            
        end
    end
    
    error('Hey what?')
    
end

function M = ref_mat(theta)
    M = [cos(2 * theta), sin(2 * theta); sin(2 * theta), - cos(2 * theta)];
end
