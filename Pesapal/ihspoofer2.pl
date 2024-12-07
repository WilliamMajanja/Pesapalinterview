#!/usr/bin/perl

use strict;
use warnings;
use Image::Magick;

sub pHash {
    my $img = shift;

    # Resize the image to 32x32 pixels
    $img->Resize(geometry => "32x32!");

    # Convert to grayscale
    $img->Set(colorspace => "GrayScale");

    # Compute the Discrete Cosine Transform (DCT)
    my $dct = $img->DCT();

    # Take the top-left 8x8 block of DCT coefficients
    my @dct_lowfreq = @$dct[0..7][0..7];

    # Calculate the mean value of the DCT coefficients
    my $avg = 0;
    foreach my $row (@dct_lowfreq) {
        foreach my $val (@$row) {
            $avg += $val;
        }
    }
    $avg /= 64;

    # Compare each coefficient to the mean and assign a bit
    my $hash_value = "";
    foreach my $row (@dct_lowfreq) {
        foreach my $val (@$row) {
            $hash_value .= $val > $avg ? "1" : "0";
        }
    }

    # Convert the binary hash to a hexadecimal string
    $hash_value = sprintf("%x", oct($hash_value));

    return $hash_value;
}

# Load two images
my $img1 = Image::Magick->new;
$img1->Read('image1.jpg');

my $img2 = Image::Magick->new;
$img2->Read('image2.jpg');

# Calculate their perceptual hashes
my $hash1 = pHash($img1);
my $hash2 = pHash($img2);

# Compare the hashes
my $hamming_distance = 0;
for (my $i = 0; $i < length($hash1); $i++) {
    $hamming_distance++ if substr($hash1, $i, 1) ne substr($hash2, $i, 1);
}

print "Hamming Distance: $hamming_distance\n";

if ($hamming_distance < 5) {
    print "Images are similar\n";
} else {
    print "Images are different\n";
}
