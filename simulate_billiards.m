% simulates a billiards run on the stadium
% @params:
%   l length of stadium
%   r radius of stadium
%   startPos starting [x y] of ball OR fraction of border that is the starting position from
%       top left corner
%   velDir direction of travel from east in range of 0-2*pi
function simulate_billiards(l, r, startPos, velDir, n, varargin)
    numvarargs = length(varargin)
    if (numvarargs > 0)
        color = varargin{1}
    else 
        color = 'r';
    end
    if (length(startPos) == 2)
        x = startPos(1); y = startPos(2);
    else 
        [x y] = convert_prop_to_xy(l, r, startPos);
    end
    draw_stadium(l,r);
    hold on
    xold = x
    yold = y
    
    p = plot(x,y);
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
        %pause(.03);
    end
    set(p,'Color', color, 'MarkerSize', 15, 'Marker', 's', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', color);
    set(pl,'Color', color);
end
