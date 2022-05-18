#!/bin/bash
function choose() {
  version=$(zenity --entry --title "Selcet gromacs version" --text none /usr/local /opt none --text "Please select executable gromacs.")
  protein="$(zenity --file-selection --title='Select a receptor File(pdb)')"
  ligand="$(zenity --file-selection --title='Select a ligand File(pdb)')"
  ligitpf="$(zenity --file-selection --title='Select a ligand ITP File(itp)')"
  cp $ligitpf $protein $ligand .
  base_name=$(basename ${ligitpf})
  
  case $? in
           0)
                  topology;;
           1)
                  zenity --question \
                         --title="receptor.pdb" \
                         --text="No file selected. Do you want to select one?" \
                         && choose || exit;;
          -1)
                  echo "An unexpected error has occurred."; exit;;
  
  esac
}

function topology() {
	source $version/gromacs/bin/GMXRC
	gmx pdb2gmx -f "$protein" -ignh  -ff charmm27 -water TIP3P
	gmx editconf -f "$ligand" -o lig.gro
cat << EOF > gmx_input_edit.py
#!/usr/bin/python
import fnmatch
import os
def replace_line(file_name, line_num, text): # to replace the count of atoms
    lines = open(file_name, 'r').readlines()
    lines[line_num] = text
    out = open(file_name, 'w')
    out.writelines(lines)
    out.close()
with open('conf.gro', 'r') as file:
    with open('lig.gro', 'r') as foo:
    # read a list of lines into data
        dat2 = foo.readlines()
    data = file.readlines()
    
with open('conf.gro', 'w') as file:
    dat3 = data[0:-1] + dat2[2:-1]# concatenate the conf.gro and lig.gro
    file.writelines(dat3)
with open('conf.gro', 'r') as fp:
    for count, line in enumerate(fp): #count the lines in conf.gro file
        pass
    acount = str(count - 1) # conversion of integer into text
    acount1 = ' ' + acount + '\n' # text supplied with space and insert a new line
def replace_line(file_name, line_num, text): # to replace the count of atoms
    lines = open(file_name, 'r').readlines()
    lines[line_num] = text
    out = open(file_name, 'w')
    out.writelines(lines)
    out.close()
replace_line('conf.gro', 1, acount1)
def search_string_in_file(file_name, string_to_search):
    """Search for the given string in file and return lines containing that string,
    along with line numbers"""
    line_number = 0
    list_of_results = []
    # Open the file in read only mode
    with open(file_name, 'r') as read_obj:
        # Read all lines in the file one by one
        for line in read_obj:
            # For each line, check if line contains the string
            line_number += 1
            if string_to_search in line:
                # If yes, then add the line number & line as a tuple in the list
                list_of_results.append((line_number, line.rstrip()))
    # Return list of tuples containing line numbers and lines where string is found
    return list_of_results
for file1 in os.listdir('.'):
    if fnmatch.fnmatch(file1, '$base_name'): #file1 for lig.itp 
        ligitp = '#include "' + file1 + '"' + "\n"
        matched_lines = search_string_in_file(file1, '[ moleculetype ]')
        print('Total Matched lines : ', len(matched_lines))
        for elem2 in matched_lines:
            elm3 = elem2[0] + 1
            replace_line(file1, elm3, 'ligand     3\n')
for file in os.listdir('.'):
    if fnmatch.fnmatch(file, '*ol.top'):
        matched_lines = search_string_in_file(file, '.ff/forcefield.itp')
        print('Total Matched lines : ', len(matched_lines))
        for elem in matched_lines:
            elm1 = elem[0] #+ 1
        with open(file, 'r') as tip:
            data = tip.readlines()
            #print(file)
            #ligitp = '#include "' + file + '"' + data[19] + "\n"
            #ligitp =  '#include "lig_sam.itp"' + data[19] + '\n'
            LIG =  data[-1] + 'ligand              1\n'#replace_line(file, -1, LIG)
            replace_line(file, elm1, ligitp)
            replace_line(file, -1, LIG )
EOF
chmod 755 gmx_input_edit.py
./gmx_input_edit.py
	source $version/gromacs/bin/GMXRC || source /opt/gromacs/bin/GMXRC
	gmx=gmx
	case $? in
           0)
                  output;;
           1)
                  zenity --question \
                         --title="location" \
                         --text="No location selected. Do you want to select one?" \
                         && version || exit;;
          -1)
                  echo "An unexpected error has occurred."; exit;;
  
  esac
}

function output() {
  mkdir output
  cp  *.itp *.top *.pdb *.gro output/
  tar -czf mytar.tar.gz output/
  rm -rf ./output/ *.itp *.top *.pdb *.gro
  zenity --info --title="Hey buddy" --text="You have done it Successfully! This program has written by Mr. Harvinder Singh, PhD scholar, Dept. of Pharmacology, PGIMER, Chandigarh harvindermaan4@gmail.com"
}
choose

