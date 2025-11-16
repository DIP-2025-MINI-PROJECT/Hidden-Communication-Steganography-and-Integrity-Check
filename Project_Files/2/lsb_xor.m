clc;
clear all;
close all;

% Read the carrier and secret images
carrier = imread('testimage.png');
secret = imread('Secret.png');

subplot(2,2,1);
imshow(carrier);
title('Carrier Image');

% Resize secret image to match carrier size
[r, c, g] = size(carrier);
secret = imresize(secret, [r c]);

% ---- Encrypt the secret image using XOR with a key ----
key = uint8(123); % Choose any number between 0-255 as key
encryptedSecret = bitxor(secret, key);

% Separate RGB channels
ra = carrier(:,:,1);
ga = carrier(:,:,2);
ba = carrier(:,:,3);

rx = encryptedSecret(:,:,1);
gx = encryptedSecret(:,:,2);
bx = encryptedSecret(:,:,3);

% Embed secret bits into carrier image (1-LSB Steganography)
for i = 1:r
    for j = 1:c
       fr(i,j) = bitand(ra(i,j), 254) + bitshift(bitand(rx(i,j),128), -7);
    end
end
redsteg = fr;

for i = 1:r
    for j = 1:c
       fr(i,j) = bitand(ga(i,j), 254) + bitshift(bitand(gx(i,j),128), -7);
    end
end
greensteg = fr;

for i = 1:r
    for j = 1:c
       fr(i,j) = bitand(ba(i,j), 254) + bitshift(bitand(bx(i,j),128), -7);
    end
end
bluesteg = fr;

% Combine all stego channels
stegoImage = cat(3, redsteg, greensteg, bluesteg);
subplot(2,2,2);
imshow(stegoImage);
title('Stego Image');

% ---- Extract the hidden image ----
redSteg = stegoImage(:,:,1);
greenSteg = stegoImage(:,:,2);
blueSteg = stegoImage(:,:,3);

for i = 1:r
    for j = 1:c
        ms(i,j) = bitand(redSteg(i,j), 1) * 128;
    end
end
recoveredR = ms;

for i = 1:r
    for j = 1:c
        ms(i,j) = bitand(greenSteg(i,j), 1) * 128;
    end
end
recoveredG = ms;

for i = 1:r
    for j = 1:c
        ms(i,j) = bitand(blueSteg(i,j), 1) * 128;
    end
end
recoveredB = ms;

recoveredEncrypted = cat(3, recoveredR, recoveredG, recoveredB);

% ---- Decrypt the recovered secret image using the same key ----
recoveredSecret = bitxor(recoveredEncrypted, key);

subplot(2,2,3);
imshow(recoveredSecret);
title('Recovered Secret Image');
