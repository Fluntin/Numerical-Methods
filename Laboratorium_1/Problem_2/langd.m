function length = langd()
    % Parameters
    rb = 1.4;
    ra = 0.9;
    rc = 0.6;
    a = [0.0; 1.3]';
    b = [3; 0.5]';
    c = [0.5; -2.0]';
    X0 = [4; 5; 8; 4];
    X1 = [-2; 2; -2; -4];
    X2 = [4; -1; 2; -3];
    tau = 10^-10;

    % Compute the points on the circles
    XAB = punkter(X0, ra, rb, a, b, tau);
    XAC = punkter(X1, ra, rc, a, c, tau);
    XBC = punkter(X2, rb, rc, b, c, tau);

    % Compute the distances and angles
    [da,aa] = get_arc(ra, XAB(1:2), XAC(1:2));
    [db,ab] = get_arc(rb, XAB(3:4), XBC(1:2));
    [dc,ac] = get_arc(rc, XAC(3:4), XBC(3:4));
    ab_len = norm(XAB(1:2) - XAB(3:4));
    ac_len = norm(XAC(1:2) - XAC(3:4));
    bc_len = norm(XBC(1:2) - XBC(3:4));

    % Compute the total length
    length = ab_len + ac_len + bc_len + da + db + dc;

    % Visualize the results
    figure()
    hold on
    viscircles(a,ra,'EdgeColor', 'blue'); 
    viscircles(b,rb,'EdgeColor', 'yellow');
    viscircles(c,rc,'EdgeColor', 'red');
    text(c(1) + 0.15, c(2), "C");
    text(b(1) + 0.15, b(2), "B");
    text(a(1) + 0.15, a(2), "A");
    plot(XAB(1:2:end), XAB(2:2:end), "k*");
    plot(XAC(1:2:end), XAC(2:2:end), "k*");
    plot(XBC(1:2:end), XBC(2:2:end), "k*");
    plot(XAB([1 3]), XAB([2 4]), '-', 'Color', 'black', 'LineWidth', 2);
    plot(XAC([1 3]), XAC([2 4]), '-', 'Color', 'c', 'LineWidth', 2);
    plot(XBC([1 3]), XBC([2 4]), '-', 'Color', 'green', 'LineWidth', 2);
    axis equal
    hold off
end

function [d,a] = get_arc(r, p1, p2)
    d = r * acos(dot(p1-p2, [1;-1]) / norm(p1-p2));
    a = 2 * asin(norm(p1-p2) / (2*r));
end

