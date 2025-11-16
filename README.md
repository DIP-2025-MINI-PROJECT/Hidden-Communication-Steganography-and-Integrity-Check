# Hidden Communication Project (LSB + XOR Steganography)

This project demonstrates hidden communication using LSB steganography and XOR-based encryption. Users can hide text or an image inside a carrier image with minimal visible distortion.

---

## Project Structure

### Methods Implemented

1. **Text Encryption using LSB**
    - **Grayscale Image Steganography**
    - **Colour Image Steganography**
      - Uses Least Significant Bit (LSB) manipulation to embed secret text inside a grayscale or colour image.

2. **Image-in-Image Steganography (with XOR Encryption)**
    - Hides an entire image inside another image.
    - Secret image is first encrypted using XOR with a key.
    - Only the MSB of the encrypted secret is stored in the LSB of the carrier, ensuring minimal distortion.

---

## Course Concepts Used

- Image Sampling and Quantization
- Linear & Nonlinear Operations
- Spatial Domain Processing
- Grayscale and RGB Image Processing

---

## Additional Concepts Used

- LSB substitution
- XOR encryption
- Binary and ASCII conversion

---

## Inputs and Outputs

### Inputs

- Carrier image (grayscale or colour)
- Secret text or secret image
- XOR key

### Outputs

- Stego image
- Extracted text (for Method 1)
- Recovered secret image (for Method 2)

---

## References

- [GeeksforGeeks – LSB Steganography](https://www.geeksforgeeks.org/computer-graphics/lsb-based-image-steganographyusing-matlab/)
- [MATLAB FileExchange – LSB Substitution](https://in.mathworks.com/matlabcentral/fileexchange/41326-steganography-usinglsb-substitution?requestedDomain=)
- [YouTube Tutorial 1](https://www.youtube.com/watch?v=ZXfNhSlXT0w)
- [YouTube Tutorial 2](https://www.youtube.com/watch?v=e3ccQogNh70)

