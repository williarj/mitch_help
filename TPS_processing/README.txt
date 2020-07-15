For detailed information on the arguments to the script you can type:

python subsetTPD.py -h

Note, this script requires python 3 to function.

Quick start examples:

python3 subsetTPS.py test_images.txt AMD_2_13_20.TPS -o output.txt
python3 subsetTPS.py test_images.txt AMD_2_13_20.TPS AMD_2_13_20_two.TPS -o output.txt

These two will produce slightly different output files. The first will give errors about missing image data, and the second should complete without the warning. 
You can include any number of TPS files as input after the image file name and before the output file name.
