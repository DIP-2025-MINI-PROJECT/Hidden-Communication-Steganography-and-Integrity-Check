# Hidden-Communication-Steganography-and-Integrity-Check

This project demonstrates hidden communication using LSB steganography and XOR-based encryption.
Users can hide text or an image inside a carrier image with minimal visible distortion.

Project Structure
Methods Implemented
1. Text Encryption using LSB

-(a) Grayscale Image Steganography

-(b) Colour Image Steganography
Uses Least Significant Bit (LSB) manipulation to embed secret text inside a grayscale or colour image.

2. Image-in-Image Steganography (with XOR Encryption)

Hides an entire image inside another image.

Secret image is first encrypted using XOR with a key.

Only the MSB of encrypted secret is stored in the LSB of carrier, ensuring minimal distortion.

Course Concepts Used

Image Sampling and Quantization

Linear & Nonlinear Operations

Spatial Domain Processing

Additional Concepts Used

LSB substitution

XOR encryption

Binary and ASCII conversion

Inputs and Outputs
Inputs

Carrier image (grayscale or colour)

Secret text or secret image

Optional XOR key

Outputs

Stego image

Extracted text (for Method 1)

Recovered secret image (for Method 2)

Grayscale and RGB Image Processing
