function res = play_billiards(l,r)
    num_simulation = 30;
    colors = [1 0 0;
        0 .7 0;
        0 0 1;
        1 1 0;
        .7 0 .4;
        0 .5 .5;
        0 0 0]
    clc;
    close all;
    draw_stadium(l,r);
    set(gcf, 'WindowButtonMotionFcn', @mouseMove);
    set(gcf, 'WindowButtonDownFcn', @mouseDown);
    current_color = 1;
    first_point_set = false;
    startX = 0; startY = 0;
%     [xin yin] = ginput(2);
%     startX = xin(1); startY = yin(1);
%     velDir = atan2((yin(2) - yin(1)), (xin(2) - xin(1)))
%     simulate_billiards(l,r, [startX startY], velDir, num_simulation);
    function mouseMove(object, eventdata)
        C = get (gca, 'CurrentPoint');
        title(gca, ['(X,Y) = (', num2str(C(1,1)), ', ',num2str(C(1,2)), ')']);
    end

    function mouseDown(object, eventdata)
        C = get (gca, 'CurrentPoint');
        if (first_point_set)
            first_point_set = false;
            %disp(['X, Y, X2, Y2 = ', num2str(startX), ',', num2str(startY), ' , ', num2str(C(1,1)), ',' num2str(C(1,2))]);
            if (C(1,2) ~= startY || C(1,1) ~= startX)
                velDir = atan2((C(1,2) - startY), (C(1,1) - startX));
                color = colors(current_color, :);
                current_color = mod(current_color + 1, length(colors(:,1))) + 1;
                simulate_billiards(l,r, [startX startY], velDir, num_simulation, color);
            else
               clf;
               draw_stadium(l, r);
            end
        else
            first_point_set = true;
            startX = C(1, 1); startY = C(1, 2);
        end
        
    end
end


