import sys, argparse

def main():
  args = parseArgs()
  
  images = getImages(args.image_file)
  
  found_data = []
  for f in args.tps_files:
    images, data = searchFile(images, f)
    found_data += data

  outputData(found_data, args.output)

  outputMissing(images)

def outputMissing(images):
  if images: sys.stderr.write("The following images were not found in any provided files. Check the image names are correct and that you provided the necessary TPS source file.\n%s\n" % ("\n".join(images)))

def outputData(data, output_file):
  out = ""
  i = 0
  for block in data:
    out += "%sID=%s\n\n" % (block, i)
    i+=1

  if output_file:
    o = open(output_file, "w")
    o.write(out)
    o.close()
  else:
    print(out)

def searchFile(images, tps_file):
  current_data = ""
  found_data = []
  for line in open(tps_file):
    if line.startswith("LM"):
      #found a new block, chuck the old one
      current_data = line
      continue
    current_data += line
    if line.startswith("IMAGE"):
      #found end of block, check it
      #this will ignore the ID lines, which we will output manually.
      name = line.split("=")[1].rstrip()
      name = name.split("\\")[-1]#gets rid of windows path names in files
      if name in images:#this is a keeper
        sys.stderr.write("Found data for image %s...\n"%(name))
        found_data.append(current_data)
        images.remove(name)
  sys.stderr.write("File %s processing complete. Images remaining: %s\n" % (tps_file, len(images)))
  return images, found_data      

def getImages(image_file):
  images = []
  for line in open(image_file):
    line = line.rstrip()
    if line:
      images.append(line)
  sys.stderr.write("Image file read, found %s image names to search for...\n" % len(images))
  return images

def parseArgs():
  parser = argparse.ArgumentParser(description="Takes a list of image files and searches through provided TPS files to extract the landmark info and make a new TPS file with only the specified image info")
  parser.add_argument("image_file", type=str, help="The path to the file listing the desiered images. Each image name should be listed on its own line.")
  parser.add_argument("tps_files", action="extend", nargs="+", type=str, help="the paths to the tps files to search should be provided here. Any number of files can be specified.")
  parser.add_argument("-o","--output", type=str, default="", help="Optional file name to put the new TPS outptu to. If no filename is provided the output will print to console.")


  return parser.parse_args()

if __name__=="__main__":
  main()
