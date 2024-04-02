conda config --show channels
conda create -n variant-calling fastqc multiqc bwa samtools freebayes bcftools tabix
conda activate variant-calling
mkdir stage2
cd ~/stage2
cd stage2
mkdir project2
cd project2
mkdir fastq
mkdir ref
ls
cd fastq
wget -O ERR8774458_1.fastq.gz https://zenodo.org/records/10426436/files/ERR8774458_1.fastq.gz?download=1
wget -O ERR8774458_2.fastq.gz https://zenodo.org/records/10426436/files/ERR8774458_2.fastq.gz?download=1
ls
cd ref
wget -O Reference.fasta https://zenodo.org/records/10886725/files/Reference.fasta?download=1
ls
cd project2
cd ..
cd fastq
fastqc fastq/* .fastq.gz
ls
multiqc fastq/*_fastqc.zip
multiqc
multiqc fastq/* _fastqc.zip
multiqc fastq/*
ls
mkdir raw_reads
cd project2
cp ./fastq/ERR8774458_1.fastq.gz ./raw_reads
cp ./fastq/ERR8774458_2.fastq.gz ./raw_reads
cd raw_reads
ls
cd ..
cd project2
mkdir trimmed_reads
cd trimmed_reads
conda install -c bioconda fastp
clear
cat raw_reads
cd ..
cd raw_reads
fastp -i ERR8774458_1.fastq.gz -I ERR8774458_2.fastq.gz -o trimmed-ERR8774458_1.fastq.gz -O trimmed-ERR8774458_2.fastq.gz
ls
cp ./raw_reads/trimmed-ERR8774458_1.fastq.gz ./trimmed_reads
cd ..
ls
cp ./raw_reads/trimmed-ERR8774458_1.fastq.gz ./trimmed_reads
cp ./raw_reads/trimmed-ERR8774458_2.fastq.gz ./trimmed_reads
cd trimmed_reads
ls
fastqc trimmed_reads/* fastq.gz
cd ..
fastqc trimmed_reads/* fastq.gz
ls
cd trimmed_reads
 ls
multiqc trimmed-ERR8774458_1_fastqc.zip trimmed-ERR8774458_2_fastqc.zip
ls
cd ref
ls
bwa index Reference.fasta
ls
mkdir BAMS

  
 mv Reference.fasta index/
 bwa index index/Reference.fasta
 cd BAMS
ls
 cp  ./trimmed-ERR8774458_1.fastq.gz ./BAMS
cp ./trimmed-ERR8774458_2.fastq.gz ./BAMS
ls
bwa mem -t 8 index/Reference.fasta trimmed-ERR8774458_1.fastq.gz trimmed-ERR8774458_2.fastq.gz > output.sam
 ls
du -sh output.sam
samtools view -b output.sam > output.bam
du -sh output.bam
rm output.sam
 samtools sort -o output.sorted.bam output.bam
ls
samtools index output.sorted.bam
ls
samtools flagstat output.sorted.bam
 samtools -b -F 0xc BAMS/output.sorted.bam -o BAMS/output.filtered.bam
 samtools view -b -F 0xc BAMS/output.sorted.bam -o BAMS/output.filtered.bam
  ls
  cd BAMS
  samtools markdup -r -@ 8 BAMS/output.sorted.bam BAMS/output.dedup.bam
  cd BAMS
 du -sh output.fixmate.bam
  samtools sort -@ 8 BAMS/output.fixmate.bam -o BAMS/output.sorted.p.bam
 mkdir output
 cp ./BAMS/output.fixmate.bam ./output
  cd output
 ls
 cd output
samtools sort -@ 8 output.fixmate.bam -o output/output.sorted.p.bam
cd ..
mkdir VCF
wget https://zenodo.org/records/10886725/files/Reference.fasta
ls
bwa index Reference.fasta
ls
freebayes -f Reference.fasta -b output.sorted.bam > output.vcf
ls
du -sh output.vcf
bgzip output.vcf
ls
bcftools index output.vcf.gz
zgrep -v -c '^#'output.vcf.gz
bcftools view -v indels output.vcf.gz|grep -v -c '^#'
bcftools view -v snps output.vcf.gz|grep -v -c '^#'
bcftools view -v snps output.vcf.gz -Oz -o snps.vcf.gz
ls
zgrep -v -c '^#' snps.vcf.gz
bcftools filter -i "QUAL>=30" output.vcf.gz -oz -o variants.filtered.vcf.gz
zgrep -v -c '^#' variants.filtered.vcf.gz

 



















































