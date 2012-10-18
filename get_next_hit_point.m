% returns the position of the next point that this ball will hit
function [xnew, ynew, newVelDir] = get_next_hit_point(l, r, xold, yold, velDir)
    % see x intersection with top line. new point will be (xnew, r)
    xnew = (r - yold)/tan(velDir) + xold;
    ynew = r;
    % if not same point and in line segment
    if ( (chop(xold) ~= chop(xnew) || chop(yold) ~= chop(ynew)) && (xnew <= l/2 && xnew >= - l/2) )
        newVelDir = (mod(pi - velDir, 2 * pi));
        return;
    end
    
    % see x intersection with bottom line. new point will be (xnew, -r)
    xnew = (-r - yold)/tan(velDir) + xold;
    ynew = -r;
    % if not same point and in line segment
    if ( (chop(xold) ~= chop(xnew) || chop(yold) ~= chop(ynew)) && (xnew <= l/2 && xnew >= - l/2) )
        newVelDir = (mod(pi - velDir, 2 * pi));
        return;
    end
    
    % right semicircle
    dx = cos(velDir);
    dy = sin(velDir);
    D = (xold - l/2) * (yold + dy) - (xold - l/2 + dx) * (yold);
    discriminant = r^2 - D^2
    if (discriminant >=0)
        xnew = D * dy + sgn(dy) * dx * sqrt(discriminant)
        ynew = -D * dx + abs(dy) * sqrt(discriminant)
        if (xnew > 0 && (chop(xold) ~= chop(xnew+l/2) || chop(yold) ~= chop(ynew)))
            % need to reflect over xnew, ynew normal direction
            newVelDir = (2 * atan2(ynew, xnew) - velDir);
            %newVel = ref_mat(atan2(ynew, xnew)) * [dx;dy];
            %newVelDir = atan2(newVel(2), newVel(1));
            xnew = xnew + l/2;
            return;
        else
            xnew = D * dy - sgn(dy) * dx * sqrt(discriminant);
            ynew = -D * dx - abs(dy) * sqrt(discriminant);
            if (xnew > 0 && (chop(xold) ~= chop(xnew+l/2) || chop(yold) ~= chop(ynew)))
                % need to reflect over xnew, ynew normal direction
                newVelDir = (2 * atan2(ynew, xnew) - velDir);
                xnew = xnew + l/2;
                return;
            end
            
        end
    end
    
    % now left semicircle
    D = (xold + l/2) * (yold + dy) - (xold + l/2 + dx) * (yold);
    discriminant = r^2 - D^2
    if (discriminant >=0)
        xnew = D * dy + sgn(dy) * dx * sqrt(discriminant);
        ynew = -D * dx + abs(dy) * sqrt(discriminant);
        if (xnew < 0 && (chop(xold) ~= chop(xnew-l/2) || chop(yold) ~= chop(ynew)))
            % need to reflect over xnew, ynew normal direction
            newVelDir = (2 * atan2(ynew, xnew) - velDir);
            xnew = xnew - l/2;
            return;
        else
            xnew = D * dy - sgn(dy) * dx * sqrt(discriminant);
            ynew = -D * dx - abs(dy) * sqrt(discriminant);
            if (xnew < 0 && (chop(xold) ~= chop(xnew-l/2) || chop(yold) ~= chop(ynew)))
                % need to reflect over xnew, ynew normal direction
                newVelDir = (2 * atan2(ynew, xnew) - velDir);
                xnew = xnew - l/2;
                return;
            end
            
        end
    end
    
    error('Hey what?')
    
end


% Chops off the decimal points of a number to a suppled number.
% If no number of decimal places is provided, defaults to 8.
% @params
%   n: number of decimal places to cut off
function res = chop(X, n)
    switch nargin
    case 2
    case 1
        n = 5;
    end
    
    res = round(X*10^n)/10^n;
end

% does the sgn function, but with no 0
function res=sgn(x)
    res = sign(x)
    if (~res)
        res = 1;
    end
end

% function M = ref_mat(theta)
%     M = [cos(2 * theta), sin(2 * theta); sin(2 * theta), - cos(2 * theta)];
% end