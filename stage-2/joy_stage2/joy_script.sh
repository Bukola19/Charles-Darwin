    1  joyadeoti
    2  desktop
    3  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    4  -h
    5  help
    6  touch ~/.hushlogin
    7  ssh vivek@192.168.2.17
    8  ls
    9  touch $HOME/.hushlogin
   10  BASH#
   11  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   12  touch ~/.hushlogin
   13  ssh vivek@192.168.2.17
   14  wsl --list --online
   15  apt install wsl
   16  wsl --install -d <DistroName>
   17  bash
   18  .sh
   19  .sh file
   20  #
   21  cd
   22  echo Hello
   23  echo Hello
   24  vim textfile.txt
   25  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   26  bash Anaconda3-24.1.2-Linux-x86_64.sh
   27  curl -O https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Windows-x86_64.exe
   28  bash Anaconda3-24.1.2-Linux-x86_64.sh
   29  wget https://repo.continuum.io/archive/Anaconda3-24.1.2-Linux-x86_64.sh
   30  wget https://repo.continuum.io/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
   31  bash Anaconda3-2024.02-1-Linux-x86_64.sh
   32  $ which python
   33  which python
   34  conda activate joy_stage2
   35  conda info --envs
   36  conda create --name joy_stage2
   37  conda activate joy_stage2
   38  conda install bioconda::fastqc
   39  fastqc
   40  conda install bioconda::bwa
   41  conda install bioconda::multiqc
   42  conda install bioconda/label/cf201901::multiqc
   43  conda install bioconda/label/cf201901::bedtools
   44  conda install bioconda/label/cf201901::bcftools
   45  conda install bioconda/label/cf201901::samtools
   46  conda install bioconda/label/cf201901::tabix
   47  conda install bioconda/label/cf201901::freebayes
   48  conda install bioconda/label/cf201901::fastp
   49  conda install bioconda/label/cf201901::multiqc
   50  conda install bioconda/label/cf201901::multiqc-bcbio
   51  conda config --set solver libmamba
   52  conda install bioconda/label/cf201901::multiqc
   53  conda install bioconda::multiqc
   54  multiqc
   55  apt install multiqc
   56  sudo apt-get install multiqc
   57  conda install -c bioconda multiqc
   58  python --version
   59  conda install python=3.5
   60  conda install -c bioconda multiqc
   61  multiqc
   62  ls
   63  conda activate joy_stage2
   64  ls
   65  ls joy_stage2
   66  conda info --envs
   67  pwd
   68  cd variant_calling/
   69  ls
   70  ls data
   71  ls fastq
   72  ls data/fastq
   73  rm ERR8774458_1.fastq.gz.1
   74  cd data/fastq/
   75  rm ERR8774458_1.fastq.gz.1
   76  ls data/fastq
   77  ls
   78  ls data/ref
   79  cd .
   80  cd ..
   81  cd ...
   82  cd variant_calling
   83  cd variant_calling/
   84  pwd
   85  cd .
   86  cd ..
   87  ls data/ref
   88  clear
   89  ls
   90  clear
   91  fastqc data/fastq/*.fastq.gz
   92  ls data/fastq/
   93  rmdir data/fastq/
   94  ls
   95  cd data/fastq/
   96  ls
   97  rm ERR8774458_1.fastq.gz
   98  ls
   99  rm ERR8774458_2_fastqc.html
  100  rm ERR8774458_2_fastqc.zip
  101  ls
  102  cd variant_calling/
  103  pwd
  104  cd variant_calling
  105  cd variant_calling/
  106  cd ~
  107  cd variant_calling/
  108  wget -P data/fastq/ https://zenodo.org/records/10426436/files/ERR8774458_1.fastq.gz
  109  fastqc data/fastq/*.fastq.gz
  110  ls data/fastq/
  111  multiqc data/fastq/*_fastqc.zip
  112  clear
  113  ls data/ref
  114  bwa index data/ref/Reference.fasta 
  115  ls data/ref
  116  ls data/fastq/*.fastq.gz
  117  ref=data/ref/Reference.fasta
  118  read1=data/fastq/ERR8774458_1.fastq.gz 
  119  read2=data/fastq/ERR8774458_2.fastq.gz 
  120  RGID="000"
  121  RGSN="ERR"
  122  readgroup="@RG\\tID:${RGID}\\tPL:Illumina\\tPU:None\\tLB:None\\tSM:${RGSN}"
  123  echo $readgroup
  124  mkdir BAMS
  125  bwa mem -t 8 -R "$readgroup" $ref $read1 $read2|samtools view -h -b -o BAMS/ERR.raw.bam
  126  ls BAMS/
  127  which samtools
  128  bwa mem -t 8 -R "$readgroup" $ref $read1 $read2|samtools view -h -b -o BAMS/ERR.raw.bam
  129  history
  130  which samtools
  131  conda update samtools
  132  bwa mem -t 8 -R "$readgroup" $ref $read1 $read2|samtools view -h -b -o BAMS/ERR.raw.bam
  133  ls BAMS/
  134  samtools flagstat BAMS/ERR.raw.bam 
  135  clear
  136  samtools view -b -F 0xc BAMS/ERR.raw.bam -o BAMS/ERR.filtered.bam
  137  ls BAMS/
  138  samtools sort -@ 8 -n BAMS/ERR.filtered.bam -o BAMS/ERR.sorted.n.bam
  139  conda install -c conda-forge ncurses 
  140  samtools sort -@ 8 -n BAMS/ERR.filtered.bam -o BAMS/ERR.sorted.n.bam
  141  samtools sort -n BAMS/ERR.filtered.bam -o BAMS/ERR.sorted.n.bam
  142  ls BAMS/
  143  samtools fixmate -m BAMS/ERR.sorted.n.bam BAMS/ERR.fixmate.bam
  144  samtools sort BAMS/ERR.fixmate.bam -o BAMS/ERR.sorted.p.bam
  145  samtools markdup -r BAMS/ERR.sorted.p.bam  BAMS/ERR.dedup.bam
  146  ls BAMS/
  147  samtools index BAMS/ERR.dedup.bam 
  148  ls BAMS/
  149  mkdir VCF
  150  clear
  151  freebayes -f data/ref/Reference.fasta -b BAMS/ERR.dedup.bam --vcf VCF/ERR.vcf
  152  ls data/ref
  153  freebayes -f data/ref/Reference.fasta -b BAMS/ERR.dedup.bam --vcf VCF/ERR.vcf
  154  ls VCF/
  155  bgzip VCF/ERR.vcf 
  156  ls VCF/
  157  bcftools index VCF/ERR.vcf.gz 
  158  which bcfbools
  159  bcftools
  160  conda update bcftools
  161  bcftools index VCF/ERR.vcf.gz 
  162  zgrep -v -c '^#' VCF/ERR.vcf.gz
  163  bcftools view -vsnps VCF/ERR.vcf.gz|grep -v -c '^#'
  164  no_of_snps=$(bcftools view -vsnps VCF/ERR.vcf.gz|grep -v -c '^#')
  165  echo $no_of_snps 
  166  bcftools view -v indels VCF/ERR.vcf.gz|grep -v -c '^#' 
  167  bcftools view -v snps VCF/ERR.vcf.gz -Oz -o VCF/ERR.vcf.gz
  168  ls VCF
  169  bcftools view -v snps VCF/ERR.vcf.gz -Oz -o VCF/snps.vcf.gz
  170  ls VCF
  171  zgrep -v -c '^#' VCF/snps.vcf.gz 
  172  bcftools filter -i "QUAL>=30" VCF/ERR.vcf.gz -Oz -o VCF/variant.filtered.vcf.gz
  173  zgrep -v -c '^#' VCF/variant.filtered.vcf.gz 
  174  history
  175  history > joy_script.sh
