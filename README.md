# topology_maker
It will generate topology file for protein and ligand complex system (MD simulations)
**Requirements or Dependencies**
## Zenity (sudo apt-get install -y zenity)
### Python (sudo apt install python3 & python)
#### Gromacs (https://manual.gromacs.org/documentation/5.1.2/install-guide/)
##### R and RStudio 
(sudo apt -y install r-base
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-2022.02.2-485-amd64.deb
sudo apt install -f ./rstudio-2022.02.2-485-amd64.deb)
**Procedure or Usage**
open the RStudio
runGitHub(repo = "topology_maker", username = "harry-maan")
GUI will prompt out and hit the run button
Topology_maker will ask for receptor.pdb, ligand.pdb, ligand.itp (generate using swiss param or ligpargen) sequentially.
It will generate topology as topol.top, conf.gro (complex = protein and ligand).
Within seconds it will generate tarfile in the working directory which consists all the required files for proceeding further box and solvation step in system buillder.
We are working to develope server for automation of MD production using gromacs.
Thankyou for using topology_maker.
Please feel free to contact or any issue regarding functinality of the tool.
Harvinder Singh
Department of Pharmacology, PGIMER, ChD
harvindermaan4@gmail.com
s.harvinder.stu@pgimer.edu.in
