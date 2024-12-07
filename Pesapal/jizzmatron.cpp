#include <opencv2/opencv.hpp>
#include <iostream>

using namespace cv;
using namespace std;

string pHash(Mat img) {
    // Resize the image to 32x32 pixels
    resize(img, img, Size(32, 32));

    // Convert to grayscale
    cvtColor(img, img, COLOR_BGR2GRAY);

    // Compute the Discrete Cosine Transform (DCT)
    Mat dct;
    dct = dct(img, DCT_ROWS);

    // Take the top-left 8x8 block of DCT coefficients
    Mat dct_lowfreq = dct(Rect(0, 0, 8, 8));

    // Calculate the mean value of the DCT coefficients
    double avg = mean(dct_lowfreq)[0];

    // Compare each coefficient to the mean and assign a bit
    string hash_value = "";
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            hash_value += dct_lowfreq.at<double>(i, j) > avg ? "1" : "0";
        }
    }

    // Convert the binary hash to a hexadecimal string
    stringstream ss;
    ss << hex << stoi(hash_value, nullptr, 2);
    return ss.str();
}

int main() {
    Mat img1 = imread("image1.jpg");
    Mat img2 = imread("image2.jpg");

    string hash1 = pHash(img1);
    string hash2 = pHash(img2);

    int hammingDistance = 0;
    for (int i = 0; i < hash1.length(); i++) {
        if (hash1[i] != hash2[i]) {
            hammingDistance++;
        }
    }

    cout << "Hamming Distance: " << hammingDistance << endl;

    if (hammingDistance < 5) {
        cout << "Images are similar" << endl;
    } else {
        cout << "Images are different" << endl;
    }

    return 0;
}
