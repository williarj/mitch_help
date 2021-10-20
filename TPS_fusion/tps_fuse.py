import argparse

def main(args):
  
  entries = []
  for tps in args.tps:
    entries += parse_TPS(tps)

  update_ids(entries, args.map)
  output_TPS(entries, args.new_tps)

  pass

def output_TPS(entries, filename):
  tps_file = open(filename, 'w')
  for entry in entries:
    tps_file.write(entry.toString())

  tps_file.close()

def clean_filename(f):
  return (f.split("/")[-1])

#combining these two benaviours of outputing the map and updating the IDs at once bothers me
def update_ids(entries, filename):
  map_file = open(filename, 'w')
  map_file.write("old_filename,old_ID,new_ID\n")
  current_ID = 0
  for entry in entries:
    old_ID = entry.ID
    entry.ID = current_ID

    map_file.write("%s,%s,%s\n" % (clean_filename(entry.filename), old_ID, current_ID))

    current_ID += 1

  map_file.close()

#produces a data structure with all the TPS data
def parse_TPS(filename):
  entries = []
  
  lm = ''
  img = ''
  points = ''
  m_id = ''
  for line in open(filename, 'r'):
    if (line.startswith("LM")):
      lm = line.rstrip().split("=")[1]
    elif (line.startswith("IMAGE")):
      img = line.rstrip().split("=")[1]
    elif (line.startswith("ID")):
      m_id = line.rstrip().split("=")[1]
    else:#points line, i assume
      points += line

    if (m_id != ''): #completed an entry, build it
      entry = TPS_Entry(lm, img, m_id, points, filename)
      entries.append(entry)
      lm, img, points, m_id = '','','','' 

  return entries

class TPS_Entry:
  def __init__(self, LM, IMAGE, ID, POINTS, filename):
    self.LM = LM
    self.IMAGE = IMAGE
    self.ID = ID
    self.POINTS = POINTS
    self.filename = filename

  def toString(self):
    string = "LM=%s\n%sIMAGE=%s\nID=%s\n" % (self.LM, self.POINTS, self.IMAGE, self.ID)
    return(string)

def parse_args():
  parser = argparse.ArgumentParser(description="takes in several TPS files, creates one large fused TPS with new unique ID numbers for each entry.")
  parser.add_argument('--map', '-m', type=str, default='TPS_ID_map.csv', help='A filename where the map of old ID numbers to new ones will be saved.')
  parser.add_argument('--tps',  type=str, nargs='+', help='The list of TPS files to manipulate. They should be separated by spaces.')
  parser.add_argument('--new_tps', '-n', type=str, default='fused.TPS', help='The name of the new TPS to create')

  args = parser.parse_args()

  return args

if __name__ == '__main__':
  args = parse_args()
  main(args)
