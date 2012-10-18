% simulates a billiards run on the stadium
% @params:
%   l length of stadium
%   r radius of stadium
%   startPos starting [x y] of ball OR fraction of border that is the starting position from
%       top left corner
%   velDir direction of travel from east in range of 0-2*pi
function simulate_billiards(l, r, startPos, velDir, n, varargin)
    draw_stadium(l,r);
    hold on
    numvarargs = length(varargin);
    if (numvarargs > 0)
        color = varargin{1};
    else 
        color = 'r';
    end
    if (length(startPos) == 2)
        x = startPos(1); y = startPos(2);
        [x2, y2, velDir2] = get_next_hit_point(l, r, x, y, velDir);
        [x3, y3, velDir3] = get_next_hit_point(l, r, x2, y2, velDir);
        if (atan2( (y2 - y), (x2 - x) ) - velDir)^2 < (atan2( (y3 - y), (x3 - x) ) - velDir)^2
            
        else
            n = n - 1;
            p = plot(x,y, '.');
            pl = plot([x, x3], [y, y3]);
            set(p,'Color', color);
            set(pl,'Color', color);
            x = x3;
            y = y3;
        end
    else 
        [x y] = convert_prop_to_xy(l, r, startPos);
    end
    xold = x;
    yold = y;
    
    p = plot(x,y, '.');
    pl = plot([xold, x], [yold, y]);
    for i = 1:n
        set(p,'Color', color);
        set(pl,'Color', color);
        xold = x; yold = y;
        [x, y, velDir] = get_next_hit_point(l, r, x, y, velDir);
        p = plot(x, y, '.');
        pl = plot([xold, x], [yold, y]);
        fprintf('iter: %d    X: %.2f    Y: %.2f\n', i, x, y);
        drawnow;
        pause(.5);
    end
    set(p,'Color', color, 'MarkerSize', 15, 'Marker', 's', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', color);
    set(pl,'Color', color);
end

% 4 cycle - simulate_billiards(2, 1, 1/(2*pi + 4), atan(1/2), 10)
% 6 cycle - simulate_billiards(2, 1, 1/(2*pi + 4), atan((1+sqrt(3)/2)/1.5), 10)
% 6 cycle - simulate_billiards(2, 1, 0, pi/4, 10)

