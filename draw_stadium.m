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