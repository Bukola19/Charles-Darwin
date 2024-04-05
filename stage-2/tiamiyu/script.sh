#!/bin/bash
source ~/miniconda3/etc/profile.d/conda.sh
conda activate bioenv2

echo  '==========Creating different directories=========='
mkdir data data/fastq data/ref QC_Reports BAMS SAM VCF data/fastq/trimmed_reads

echo  '==========Getting the data=========='
ref_url='https://raw.githubusercontent.com/josoga2/yt-dataset/main/dataset/raw_reads/reference.fasta'
ref_name='reference.fasta'

curl -L "$ref_url" -o "data/ref/$ref_name"


data_url=("https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/ACBarrie_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/ACBarrie_R2.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Alsen_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Alsen_R2.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Baxter_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Baxter_R2.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Chara_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Chara_R2.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Drysdale_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Drysdale_R2.fastq.gz")


echo "==========Mapping/Indexing the Refereence Genome with BWA=========="
bwa index -a bwtsw data/ref/reference.fasta

for url in "${data_url[@]}"; do
    # Extract the sample name from the URL using cut
  name=$(basename "$url" | cut -d '_' -f 1)
  echo "======Sample: $name====="

# Download the dataset
  curl -L "$url" -o "data/fastq/${name}_R1.fastq.gz"
  curl -L "$url" -o "data/fastq/${name}_R2.fastq.gz"

  echo "Downloaded dataset for $name"


  echo "==========Performing quality control with FastQC on $name=========="
  fastqc data/fastq/${name}_R1.fastq.gz data/fastq/${name}_R2.fastq.gz -o QC_Reports

  echo "==========Trimming with FastP=========="
  fastp  -i data/fastq/${name}_R1.fastq.gz -I data/fastq/${name}_R2.fastq.gz -o data/fastq/trimmed_reads/${name}_R1.fastq.gz -O data/fastq/trimmed_reads/${name}_R2.fastq.gz --html data/fastq/trimmed_reads/${name}_fastp.html --json data/fastq/trimmed_reads/${name}_fastp.json

  echo "==========Genome Mapping/Assembling with BWA ($name)=========="
  # to map the trimmed reads to a reference genome using BWA and producing SAM output
  ref=data/ref/reference.fasta
  read1=data/fastq/trimmed_reads/${name}_R1.fastq.gz
  read2=data/fastq/trimmed_reads/${name}_R2.fastq.gz

  bwa mem $ref $read1 $read2 > SAM/${name}.sam


  # convert the SAM file into a BAM file that can be sorted and indexed
  samtools view -hbo BAMS/${name}.bam SAM/${name}.sam

  # sort the BAM file by position in genome
  samtools sort BAMS/${name}.bam -o BAMS/${name}.sorted.bam

  # index the sorted BAM file to randomly access it quickly in variant calling
  samtools index BAMS/${name}.sorted.bam

  echo "==========Performing Variant Calling with bcftools (${name})=========="
  # to call variants from the mapped reads (sorted BAM) using a variant caller bcftools

  bcftools mpileup -Ou -f $ref BAMS/${name}.sorted.bam|bcftools -Ov -mv > VCF/${name}.vcf
done

multiqc QC_Reports/*_fastqc.zip
