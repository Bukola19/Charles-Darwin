    1  help
    2  cloudshell help
    3  launch-tutorial
    4  ls
    5  dir
    6  df
    7  python 2
    8  python
    9  sudo apt-get install fastqc
   10  ls
   11  mkdir charles-darwin
   12  mkdir biocomputing && cd biocomputing
   13  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna
   14  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
   15  mv wildtype.fna ~/charles_darwin
   16  rm wildtype.gbk
   17  cat wildtype.fna
   18  grep "tatata" wildtype.fna
   19  grep "tatatata" wildtype.fna
   20  grep "tatatata" wildtype.fna > mutant_lines.txt
   21  df
   22  fastqc -a
   23  fastqc -h
   24  sudo apt-get install fastqc
   25  fastqc -h
   26  ls
   27  rm charles-darwin
   28  clear
   29  ls
   30  cd
   31  clear
   32  pwd
   33  ls
   34  rmdir charles-darwin biocomputing
   35  ls
   36  rmdir biocomputing
   37  ls
   38  clear
   39  mkdir joy
   40  mkdir biocomputing && cd biocomputing
   41  ls
   42  cd biocomputing
   43  wget 
   44  https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
   45  $ wget 
   46  https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna 
   47  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna 
   48  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk
   49  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.gbk 
   50  mv .fna ~/joy/
   51  mv *.fna ~/joy/
   52  rm wildtype.gbk.1
   53  grep ‘tatatata’ wildtype.fna 
   54  grep -o 'tatatata' wildtype.fna | wc -l
   55  grep -o 'tatatata' wildtype.fna 
   56  wget https://raw.githubusercontent.com/josoga2/dataset-repos/main/wildtype.fna 
   57  grep -o "tatatata" ~/joy/  wildtype.fna
   58  grep -o "tatatata" ~/joy/ wildtype.fna > mutant_lline.txt
   59  rm mutant_lline.txt
   60  grep -o "tatatata" ~/joy/ wildtype.fna > mutant_line.txt
   61  echo "MET"
   62  efetch -db nucleotide -id NC_000007.14 -format fasta > met.fasta
   63  sh -c "$(curl -fsSL https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh)"
   64  export PATH=${HOME}/edirect:${PATH}
   65  efetch -db nucleotide -id NC_000007.14 -format fasta > met.fasta
   66  grep -c -v "^>" met.fasta
   67  grep -v '>' met.fasta | head -n -1|wc -l
   68  head met.fasta
   69  ls
   70  cat met.fasta | grep -v ">" | wc -l
   71  history
   72  efetch -db nucleotide -id NC_000007.14 -format fasta > met.fasta
   73  met.fasta
   74  ls
   75  head(met.fasta)
   76  cat met.fasta
   77  grep -v '>' met.fasta | head -n -1|wc -l
   78  grep -v '>' met.fasta | grep -o 'A' | wc -l
   79  grep -v '>' met.fasta | grep -o 'G' | wc -l
   80  grep -v '>' met.fasta | grep -o 'C' | wc -l
   81  grep -v '>' met.fasta | grep -o 'T' | wc -l
   82  GC_Count=$(grep -v '>' met.fasta |grep -o [GC] |wc -l
Total_Count=$(grep -v '>' met.fasta |grep -o [AGTC] |wc -l)


echo $GC_content

exit()
   83  GC_count=$(grep -v '>' met.fasta |grep -o [GC] |wc -1)
   84  GC_count=$(grep -o "[GC]" met.fasta | wc -l)
   85  Total_count=$(grep -v "^>" met.fasta | tr -d "\n" | wc -c)
   86  GC_content=$(echo "scale=2; ($GC_count / $Total_count) * 100" | bc)
   87  GC_content=$(echo "scale=2; ($GC_count / $Total_count) * 100" )
   88  echo $GC_content
   89  sudo [apt-get/yum] install gawk
   90  sudo apt get install awk
   91  sudo apt-get install awk
   92  sudo apt-get install gawk
   93  grep -v "^>" met.fasta | awk 'BEGIN{FS="";GC=0;total=0} {for(i=1;i<=NF;i++) {if($i=="G" || $i=="C") GC++; total++}} END {print (GC/total)*100}'
   94  touch joy.fasta
   95* echo “A occurs: ${} times” > joy.fasta
   96  echo “C occurs: ${no_C} times” >> joy.fasta
   97  echo “T occurs: ${no_T} times” >> joy.fasta
   98  cat joy.fasta
   99  rm joy.fasta
  100  ls
  101  touch joy.fasta
  102  echo "Number of A  :$(grep -v '>' met.fasta | grep -o 'A' | wc -l)" > joy.fasta 
  103  echo "Number of G  :$(grep -v '>' met.fasta | grep -o 'G' | wc -l)" >> joy.fasta
  104  echo "Number of C  :$(grep -v '>' met.fasta | grep -o 'C' | wc -l)" >> joy.fasta
  105  echo "Number of T  :$(grep -v '>' met.fasta | grep -o 'T' | wc -l)" >> joy.fasta
  106  cat joy.fasta
  107  https://github.com/Bukola19/Charles-Darwin/tree/fe57af25bdf7a6206bd17dd43eb7086501512831/output
  108  git clone https://github.com/Bukola19/Charles-Darwin
  109  git add . joy.fasta
  110  git status
  111  git commit joy.fasta /output/
  112  git pull
  113  ls
  114  cat joy
  115  cat biocomputing
  116  https://github.com/Bukola19/Charles-Darwin/tree/main/output
  117  https://github.com/Bukola19/Charles-Darwin/blob/main/output/joy.fasta
  118  history > joy.sh
