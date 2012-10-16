function check_conversions(l, r)
    range = linspace(0,1);
    for i =1:length(range)
        [X Y] = convert_prop_to_xy(l, r, range(i));
        prop = convert_xy_to_prop(l, r, X, Y);
        prop - range(i)
    end
end