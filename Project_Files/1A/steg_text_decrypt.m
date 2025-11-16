clc;
clear;
len=str2double(input('Enter the length (character count) of the message you are looking for: ','s'));
len=len*8;
hidimg=imread("C:\Users\saura\OneDrive\ドキュメント\MATLAB\DIP\output.png");
[x,y,z] = size(hidimg);
if z > 1
    hidimg = rgb2gray(hidimg);
end
count=1;
bitseq='';
for i=1:x
    for j=1:y
        %For all the characters in the message
        if count<=len
            
            %Retrieve the LSB of the pixel value
            LSB=mod(hidimg(i,j),2);
            bitseq(count,1) = LSB;
            count=count+1;
        end
    end
end

%Converting the bit sequence into the original message using weighted
%values
weights = [ 128 64 32 16 8 4 2 1 ]; 

% elements are taken column wise from bitseq, each char has 8 bits so 8
% rows
message_matrix = reshape(bitseq,8,len/8);
original_message = char(weights*message_matrix);
disp(['The original message is: ',original_message]);
