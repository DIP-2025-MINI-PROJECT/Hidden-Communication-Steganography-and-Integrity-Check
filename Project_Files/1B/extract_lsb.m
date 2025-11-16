% extract_lsb.m
% Usage: run this script in MATLAB. It reads 'stego_image.png' and prints recovered message.

stego_filename = 'stego_image.png';
numLSB = 1;            % must match embedder
stego = imread(stego_filename);
[H,W,C] = size(stego);
pix = stego(:);        % uint8 vector

% Function to read N bits sequentially from pix vector
bit_read = [];
for i = 1 : numel(pix)
    p = pix(i);
    if numLSB == 1
        bit_read(end+1,1) = bitget(p,1); %#ok<SAGROW>
    else
        for b = 1:numLSB
            bit_read(end+1,1) = bitget(p,b);
        end
    end
end

% Read header first: 4 bytes = 32 bits * 8 = 32 bits
header_bits = bit_read(1:32);
% convert bits (MSB-first per byte) into 4 bytes
header_bytes = zeros(4,1,'uint8');
for byte = 1:4
    byte_bits = header_bits((byte-1)*8 + (1:8))';
    header_bytes(byte) = uint8(bin2dec(char(byte_bits+'0')));
end
msg_len = typecast(uint8(header_bytes), 'uint32'); % number of bytes in message

% Now extract message bits: next msg_len*8 bits
start_bit = 32 + 1;
end_bit = 32 + double(msg_len) * 8;
if end_bit > numel(bit_read)
    error('Not enough bits in image to extract the message. Expected %d bits, found %d.', end_bit, numel(bit_read));
end

msg_bits = bit_read(start_bit:end_bit);
% group into bytes and convert
msg_bytes = zeros(msg_len,1,'uint8');
for k = 1:double(msg_len)
    chunk = msg_bits((k-1)*8 + (1:8))';
    msg_bytes(k) = uint8(bin2dec(char(chunk + '0')));
end
recovered = char(msg_bytes.');
fprintf('Recovered message (%d bytes): %s\n', msg_len, recovered);
