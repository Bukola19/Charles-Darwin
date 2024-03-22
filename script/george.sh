    1  ls
    2  gcloud version
    3  clear
    4  ls
    5  conda
    6  sudo apt-get update
    7  sudo apt-get install bzip2 libxml2-dev
    8  wget https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh
    9  conda --version
   10  ls
   11  rm Anaconda3-2018.12-Linux-x86_64.sh
   12  ls
   13  wget https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
   14  ls
   15  bash Anaconda3-2024.02-1-Linux-x86_64.sh
   16  conda
   17  rm ~/home/ombudstasks/anaconda3
   18  rm -r ~/home/ombudstasks/anaconda3
   19  rm -r /home/ombudstasks/anaconda3
   20  bash Anaconda3-2024.02-1-Linux-x86_64.sh -b -p /home/ombudstasks/anaconda3
   21  wget https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
   22  ls
   23  rm Anaconda3-2024.02-1-Linux-x86_64.sh 
   24  rv Anaconda3-2024.02-1-Linux-x86_64.sh.1
   25  rm Anaconda3-2024.02-1-Linux-x86_64.sh.1
   26  wget https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
   27  ls
   28  bash Anaconda3-2024.02-1-Linux-x86_64.sh -b -p /home/ombudsman/anaconda3
   29  bash Anaconda3-2024.02-1-Linux-x86_64.sh -b
   30  bash Anaconda3-2024.02-1-Linux-x86_64.sh -u
   31  rm -r /home/ombudstasks/anaconda3
   32  bash Anaconda3-2024.02-1-Linux-x86_64.sh -b
   33  rm -r /home/ombudstasks/anaconda3
   34  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
   35  bash Miniconda3-latest-Linux-x86_64.sh -b
   36  conda
   37  echo $SHELL
   38  eval "$(/home/ombudstasks/miniconda3 shell.bash hook)"
   39  ls
   40  sudo apt-get install figlet
   41  figlet george
   42  wget -O GyrBgene2.fasta "https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?db=nuccore&report=fasta&id=PPO72261.1”
   43  wget -O GyrBgene2.fasta https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?db=nuccore&report=fasta&id=PPO72261.1
   44  wget -O GyrBgene2.fasta "https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?db=nuccore&report=fasta&id=PPO72261.1"
   45  wget -O GyrBgene2.fasta "https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?db=nuccore&report=fasta&id=PPO72261.1”
   46  wget -O GyrBgene2.fasta "https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?db=nuccore&report=fasta&id=PPO72261.1"
   47  grep -v "^>" GyrBgene2.fasta | awk 'BEGIN{FS="";GC=0;total=0} {for(i=1;i<=NF;i++) {if($i=="G" || $i=="C") GC++; total++}} END {print (GC/total)*100}'
   48  cat GyrBgene2.fasta | grep -v ">" | head -n 5
   49  cat GyrBgene2.fasta
   50  wget -O GyrBgene2.fasta "https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?db=nuccore&report=fasta&id=PPO72261.1”
   51  wget -O GyrBgene2.fasta "https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?db=nuccore&report=fasta&id=PPO72261.1"
   52  cat GyrBgene2.fasta
   53  wget -O GyrBgene2.fasta “https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?db=nuccore&report=fasta&id=PPO72261.1”
   54  wget -O GyrBgene2.fasta "https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?db=nuccore&report=fasta&id=PPO72261.1"
   55  wget -O hemoglobin_beta.fasta "https://www.ncbi.nlm.nih.gov/sviewer/viewer.cgi?db=nuccore&report=fasta&id=NM_000518.5"
   56  cat hemoglobin_beta.fasta
   57  wget -O GyrBgene2.fasta "https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?db=nuccore&report=fasta&id=PPO72261.1”
   58  wget -O GyrBgene2.fasta "https://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?db=nuccore&report=fasta&id=PPO72261.1"
   59  cat GyrBgene2.fasta
   60  mkdir charles-darwin
   61  mkdir biocomputing && cd biocomputing
   62  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna
   63  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
   64  mv *.fna ~/charles-darwin/
   65  rm wildtype.gbk.1
   66  grep -o 'tata' wildtype.fna
   67  cd ~/charles-darwin/
   68  grep -o 'tata' wildtype.fna
   69  clear
   70  grep "tatatata" wildtype.fna > mutant_lines.txt
   71  ls
   72  echo “rpob”
   73  efetch -db nuccore -id NC_000962.3 -format fasta -seq_start 759807 -seq_stop 763325 > rpob.fa
   74  sudo apt-get install -y efetch
   75  efetch -db nuccore -id NC_000962.3 -format fasta -seq_start 759807 -seq_stop 763325 > rpob.fa
   76  clear
   77  update_blastdb.pl --decompress all 
   78  efetch -db nuccore -id NC_000962.3 -format fasta -seq_start 759807 -seq_stop 763325 > rpob.fa
   79  cd ..
   80  ls
   81  cat rpob.fa | -n 5
   82  cat rpob.fa |head -n 5
   83  clear
   84  cat rpob.fa | grep -v ">" | wc -l
   85  cat rpob.fa | grep -v ">" | tr -d '\n' | grep -o 'A' | wc -l
   86  sed -n '/^[^>]/s/[^A]//gp' rpob.fa | tr -d '\n' | wc -c
   87  cat rpob.fa | grep -v ">" | tr -d '\n' | grep -o 'G' | wc -l
   88  sed -n '/^[^>]/s/[^G]//gp' rpob.fa | tr -d '\n' | wc -c
   89  cat rpob.fa | grep -v ">" | tr -d '\n' | grep -o 'C' | wc -l
   90  sed -n '/^[^>]/s/[^C]//gp' rpob.fa | tr -d '\n' | wc -c
   91  cat rpob.fa | grep -v ">" | tr -d '\n' | grep -o 'T' | wc -l
   92  sed -n '/^[^>]/s/[^t]//gp' rpob.fa | tr -d '\n' | wc -c
   93  sed -n '/^[^>]/s/[^T]//gp' rpob.fa | tr -d '\n' | wc -c
   94  grep -v "^>" rpob.fa | awk 'BEGIN{FS="";GC=0;total=0} {for(i=1;i<=NF;i++) {if($i=="G" || $i=="C") GC++; total++}} END {print (GC/total)*100}'
   95  touch george.fa
   96  ls
   97  rm george.fa
   98  cd biocomputing
   99  ls
  100  mv ~/rpob.fa ~/biocomputing/
  101  ls
  102  touch george.fa
  103  echo "Number of A: $(grep -v ">" rpob.fa | tr -d '\n' | grep -o 'A' | wc -l)" >> george.fa
  104  echo "Number of G: $(grep -v ">" rpob.fa | tr -d '\n' | grep -o 'G' | wc -l)" >> george.fa
  105  echo "Number of C: $(grep -v ">" rpob.fa | tr -d '\n' | grep -o 'C' | wc -l)" >> george.fa
  106  cd ..
  107  git clone https://github.com/Bukola19/Charles-Darwin.git
  108  git add .
  109  ls
  110  cd Charlse-Darwin
  111  cd charlse-Darwin
  112  cd charlse-darwin
  113  cd charles-darwin
  114  cat ~/george.fa
  115  cat ~/biocomputing/george.fa
  116  cp ~/biocomputing/george.fa ~/chalrse-darwin
  117  ls
  118  clear
  119  ls
  120  cd ..
  121  ls
  122  cd Charles-Darwin
  123  ls
  124  cp ~/biocomputing/george.fa ~/chalrse-darwin/output
  125  cp ~/biocomputing/george.fa ~/Chalrse-Darwin/output
  126  cp ~/biocomputing/george.fa ~/Charlse-Darwin/output
  127  cp ~/biocomputing/george.fa ~/Charles-Darwin/output
  128  ls ~/Charles-Darwin/output
  129  git add .
  130  git commit -m "added my file george.fa to the repo"
  131  git config --global user.email "steveodettegeorge@gmail.com"
  132  git config --global user.name "GeOdette"
  133  git commit -m "added my file george.fa to the repo"
  134  git push origin main
  135  clear
  136  git fetch origin
  137  git merge origin/main
  138  git add .
  139  git commit -m "added my george.fa file to the repo"
  140  git push origin main
  141  history
  142  clear
  143  cd ..
  144  pwd
  145  clear
  146  history george.sh
  147  history > george.sh
