img1 = imread("university1.png");
img2 = imread("university2.png");

%img1 = imread("tower1.jpeg");
%img2 = imread("tower2.jpeg");

%b
%PA = [165, 78; 154, 186; 327, 106; 354, 170; 340, 14; 271, 43];
%PB = [68, 88; 55, 198; 229, 123; 252, 186; 243, 34; 177, 57];

%c
H = estimate_homography(PA, PB);

%d
figure
imshow(img1);
impixelinfo;

%p1 = [168, 103];
p1 = [445,525];
p2 = apply_homography(p1, H);

figure
subplot(1,2,1), imshow(img1);
hold on;
plot(p1(1), p1(2), 'go');
hold off;

subplot(1,2,2), imshow(img2);
hold on;
plot(p2(1), p2(2), 'yo');
hold off;

%% e
canvas = padarray(img2, [size(img2,1),size(img2,2)], 0, 'both');
imshow(canvas);

x_offset = size(img2,2);
y_offset = size(img2,1);
ix = size(img1,2);
iy = size(img1,1);

for i = 1:ix*iy
    [r,c] = ind2sub([iy, ix], i);
    p1 = [c,r];
    p2 = apply_homography(p1, H);
    p2 = [p2(1)+x_offset, p2(2)+y_offset];

    canvas(ceil(p2(2)), ceil(p2(1)), :)   = img1(p1(2), p1(1), :);
    canvas(ceil(p2(2)), floor(p2(1)), :)  = img1(p1(2), p1(1), :);
    canvas(floor(p2(2)), ceil(p2(1)), :)  = img1(p1(2), p1(1), :);
    canvas(floor(p2(2)), floor(p2(1)), :) = img1(p1(2), p1(1), :);

end

imshow(canvas);



