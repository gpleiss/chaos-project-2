%
function bifurcation_diagram(l, r, startProportion, velDir, n)
    clc;
    close all;

    if (length() == 2 && length(b) == 1)
        As = linspace(a(1), a(2));
        func = func_generator(As, b);
        [fig1, fig2, fig3] = orbit_diagram_helper(func, 'a', As);
        
    elseif (length(a) == 1 && length(b) == 2)
        Bs = linspace(b(1), b(2));
        func = func_generator(a, Bs);
        [fig1, fig2, fig3] = orbit_diagram_helper(func, 'b', Bs);
        
    else
        error('Only one of l, r should be ranges');
    end
end

    % Pos = convert_prop_to_xy(l, r, startProportion);
    % x = Pos(1); y = Pos(2);
    % for i = 1:n
    %     [x, y, velDir] = get_next_hit_point(l, r, x, y, velDir);
    % end


function [fig1, fig2, fig3] = orbit_diagram_helper(func, label, Vals)
    num_iter = 1000;

    % Data structures
    X = zeros(num_iter, length(Vals)); % Value after iterations
    Y = zeros(num_iter, length(Vals)); % Value after iterations
    
    % Calculate position after iterations
    for i=2 : num_iter
        XY = func([X(i-1,:); Y(i-1,:)]);
        X(i,:) = XY(1,:);
        Y(i,:) = XY(2,:);
    end
    
    % val vs X plot
    fig1 = figure();
    plot(Vals, X(end-50:end, :), 'b.');
    xlabel(label);
    ylabel('X after iteration');
    
    % val vs Y plot
    fig2 = figure();
    plot(Vals, Y(end-50:end, :), 'b.');
    xlabel(label);
    ylabel('Y after iteration');
    
    % val vs Z plot
    fig3 = figure();
    plot3(Vals, X(end-50:end, :), Y(end-50:end, :), 'b.');
    xlabel(label);
    ylabel('X after iteration');
    zlabel('Y after iteration');
end