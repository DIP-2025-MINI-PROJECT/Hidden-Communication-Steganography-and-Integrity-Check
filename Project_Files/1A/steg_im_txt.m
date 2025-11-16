img = imread('C:\Users\saura\Downloads\DIP\Images-DIP\Mona.jpg');
img1 = imread('C:\Users\saura\Downloads\DIP\Images-DIP\Mona.jpg');
[x,y,z] = size(img);
if z > 1
    img = rgb2gray(img);
end
hidimg = img;

msg = input('Please enter the message you want to hide: ','s');
asc_val = uint8(msg);
asc_to_bin = dec2bin(asc_val,8);
bin_seq = reshape(asc_to_bin.', 1, []);  % fixed
len = length(bin_seq);

if length(msg) > (x*y)
    disp('Chosen image is not large enough to hide the message.');
end

count = 1;
for i = 1:x
    for j = 1:y
        if count <= len
            bitmsg = str2double(bin_seq(count));
            hidimg(i,j) = bitand(hidimg(i,j), 254);   % clear LSB
            hidimg(i,j) = hidimg(i,j) + bitmsg;       % embed bit
            count = count + 1;
        end
    end
end

subplot(1,2,1)
imshow(img);
title('Original Image');
subplot(1,2,2)
imshow(hidimg);
title('Encrypted Image');
imwrite(hidimg,'C:\Users\saura\OneDrive\ドキュメント\MATLAB\DIP\output.png');
