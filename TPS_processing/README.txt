For detailed information on the arguments to the script you can type:

python subsetTPD.py -h

Note, this script requires python 3 to function.

Quick start examples:

python subsetTPS.py test_images.txt AMD_2_13_20.TPS -o output.txt
python subsetTPS.py test_images.txt AMD_2_13_20.TPS AMD_2_13_20_two.TPS -o output.txt

These two will produce slightly different output files. The first will give errors about missing image data, and the second should complete without the warning. 
You can include any number of TPS files as input after the image file name and before the output file name.

Step by step how-to:

1) install python 3
2) open a command prompt (type cmd in the windows search)
3) navigate to where you want to work (probably the folder where the script is saved)
	example: cd C:\Users\mitch\Documents\mitch_help_repo\TPS_processing
4) run the program as above
	example: python subsetTPS.py test_images.txt AMD_2_13_20.TPS -o my_output.txt

Note: If you get a "No such file or directory" error you may have mispelled a file or foldername, or you need to add the full path to the input files. 
For example:

python C:\Users\mitch\Documents\mitch_help_repo\TPS_processing\subsetTPS.py C:\Users\mitch\Documents\mitch_help_repo\TPS_processing\test_images.txt C:\Users\mitch\Documents\mitch_help_repo\TPS_processing\AMD_2_13_20.TPS -o C:\Users\mitch\Documents\mitch_help_repo\TPS_processing\output.txt