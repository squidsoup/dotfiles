# Heavily depends on:
# libqrencode (fukuchi.org/works/qrencode/)
# paperkey (jabberwocky.com/software/paperkey/)
# zbar (zbar.sourceforge.net)

# Producing the QR codes:
# Split over 4 codes to ensure the data per image is not too large.
gpg --export-secret-key KEYIDGOESHERE | paperkey --output-type raw | base64 > temp
split temp -n 4 IMG
for f in IMG*; do cat $f | qrencode -o $f.png; done

# Importing the QR codes:
# Note that, when making scans or photographs, you do not produce large images.
# If zbar does not recognise your QR code, try downscaling the image.
for f in IMG*.png; do zbarimg --raw $f | head -c -1 > $f.out ; done
cat *.out | base64 -d | paperkey --pubring ~/.gnupg/pubring.gpg | gpg --import

