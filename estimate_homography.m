function [H] = estimate_homography(PA, PB)

A = [];
for i = 1:length(PA)
    x = PA(i,1);
    y = PA(i,2);
    xb = PB(i,1);
    yb = PB(i,2);
    A = [A; -x, -y, -1,  0,  0,  0, x*xb, y*xb, xb; ...
             0,  0,  0, -x, -y, -1, x*yb, y*yb, yb];
end

[~, ~, V] = svd(A);
h = V(:, end);
H = reshape(h, 3, 3)';