
cover_filename = 'C:\Users\Shreyasbavimj\Downloads\yogi reggie.jpg';       
output_filename = 'stego_image.png';
message = 'frame by frame';            % secret message
numLSB = 1;                         % number of LSBs to use per channel pixel (1 is safest)

%
cover = imread(cover_filename);
[H, W, C] = size(cover);  % C = 1 for grayscale, 3 for RGB

% Flatten pixel data channel-wise into a vector of unsigned integers
pixel_count = H * W * C;
pix = cover(:);           % column vector (uint8)

% Prepare message bits with a header length
msg_bytes = uint8(message);                 % ASCII bytes
msg_len = numel(msg_bytes);                 % number of bytes
% We'll store length as a 32-bit unsigned integer header (allows up to ~4GB message)
len_header = typecast(uint32(msg_len), 'uint8'); % 4 bytes representing length
payload = [len_header(:); msg_bytes(:)];    % first 4 bytes = length, then message bytes

% Convert payload to bit stream (MSB first for each byte)
bits = reshape(dec2bin(payload,8).' - '0', [], 1); % column vector of 0/1, length = 8*(4+msg_len)

% Check capacity
capacity_bits = double(pixel_count) * numLSB;
if numel(bits) > capacity_bits
    error('Message too large. Need %d bits but only %d bits available (numLSB=%d).', ...
          numel(bits), capacity_bits, numLSB);
end

% Embed: replace LSB(s) of pixel vector with message bits
stego_pix = uint8(pix); % copy
bit_idx = 1;
for i = 1 : numel(stego_pix)
    if bit_idx > numel(bits)
        break
    end
    % Current pixel value
    p = stego_pix(i);
    % For multi-LSB, we replace the lowest numLSB bits with the next bits chunk
    if numLSB == 1
        stego_pix(i) = bitset(p, 1, bits(bit_idx)); % set bit 1 (LSB)
        bit_idx = bit_idx + 1;
    else
        % get next numLSB bits (pad with zeros if needed)
        chunk = 0;
        for b = 1:numLSB
            if bit_idx <= numel(bits)
                chunk = chunk + bits(bit_idx) * 2^(b-1); % LSB-order insertion
            end
            bit_idx = bit_idx + 1;
        end
        % clear lowest numLSB bits then add chunk
        mask = bitcmp(uint8((2^numLSB)-1));
        stego_pix(i) = bitand(p, mask);
        stego_pix(i) = bitor(stego_pix(i), uint8(chunk));
    end
end

% Reshape back to HxWxC and save
stego_img = reshape(stego_pix, H, W, C);
imwrite(stego_img, output_filename);
fprintf('Embedding done. Wrote %s (used %d bits of %d available).\n', output_filename, min(numel(bits), capacity_bits), capacity_bits);
