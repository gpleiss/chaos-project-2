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

    [x y] = convert_prop_to_xy(l, r, startProportion);
    draw_stadium(l,r);
    hold on
    plot(x, y, 'r.');
    for i = 1:n
        xold = x; yold = y;
        plot(xold, yold, 'r.');
        [x, y, velDir] = get_next_hit_point(l, r, x, y, velDir);
        plot(x, y, '.');
        plot([xold, x], [yold, y]);
        fprintf('iter: %d    X: %.2f    Y: %.2f\n', i, x, y);
        drawnow;
        pause(.03);
    end
end


% draws the stadium with length (l) and radius (r)
function draw_stadium(l, r)
    axis equal;
    hold on;
    line([-l/2 l/2], [r, r]);
    line([-l/2 l/2], [-r, -r]);
    Theta = linspace(-pi/2, pi/2);
    plot(r * cos(Theta) + l/2, r * sin(Theta));
    plot( - r * cos(Theta) - l/2, r * sin(Theta));
    hold off;
end