import cv2
import numpy as np

def pHash(img):
    """
    Calculates the perceptual hash of an image.

    Args:
        img: The input image.

    Returns:
        The perceptual hash as a hexadecimal string.
    """

    # Resize the image to 32x32 pixels
    img = cv2.resize(img, (32, 32))

    # Convert to grayscale
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # Compute the Discrete Cosine Transform (DCT)
    dct = cv2.dct(np.float32(gray))

    # Take the top-left 8x8 block of DCT coefficients
    dct_lowfreq = dct[:8, :8]

    # Calculate the mean value of the DCT coefficients
    avg = np.mean(dct_lowfreq)

    # Compare each coefficient to the mean and assign a bit
    hash_value = ""
    for i in range(8):
        for j in range(8):
            hash_value += '1' if dct_lowfreq[i, j] > avg else '0'

    # Convert the binary hash to a hexadecimal string
    hash_value = hex(int(hash_value, 2))[2:]

    return hash_value

# Load two images
img1 = cv2.imread('Screenshot 2024-12-07 at 03-45-07 Get Kali Kali Linux.png')
img2 = cv2.imread('Screenshot 2024-12-07 at 03-44-34 Kali Linux.png')

# Calculate their perceptual hashes
hash1 = pHash(img1)
hash2 = pHash(img2)

# Compare the hashes
hamming_distance = bin(int(hash1, 16) ^ int(hash2, 16)).count('1')
print("Hamming Distance:", hamming_distance)

# If the Hamming distance is small, the images are likely similar
if hamming_distance < 5:
    print("Images are similar")
else:
    print("Images are different")
