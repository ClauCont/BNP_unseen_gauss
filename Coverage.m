function [coverage] = Coverage(int1, int2)
% int2 coverage of int1
sx1 = int1(1, :);
dx1 = int1(2, :);
sx2 = int2(1, :);
dx2 = int2(2, :);

cap_sx = max(sx1, sx2);
cap_dx = min(dx1, dx2);

len_cap = cap_dx - cap_sx;
len_1 = dx1 - sx1;

coverage = round(len_cap./len_1, 3);
end