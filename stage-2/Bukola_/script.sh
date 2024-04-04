#!/usr/bin/env bash

# make a new directory for the task titled PROJECT3 and change to the directory
mkdir PROJECT3 && cd PROJECT3

# make new directories Data, Ref, results and change to the Data directory
mkdir Data Ref Results && cd Data

# Download the forward strand
wget https://zenodo.org/records/10426436/files/ERR8774458_1.fastq.gz https://zenodo.org/records/10426436/files/ERR8774458_2.fastq.gz

# change the directory to the ref folder
cd .. && cd Ref

# download the reference sequence
wget https://zenodo.org/records/10886725/files/Reference.fasta
cd ..

# Activate the conda env
conda activate base

# change the directory to data
cd Data/

# Run the quality control
fastqc *.fastq.gz

# Move the fastqc result to Results directory
mv *_fastqc.zip *.html PROJECT3/Results/

# Change the directory to the result directory
cd .. && cd Results

# Run multiqc to aggregate the qc results
multiqc *_fastqc.zip

# Change to the Data directory
cd .. && cd Data

# Trim the sequence
fastp --thread 8 --detect_adapter_for_pe --cut_mean_quality 20 --length_required 50 --html report.html --json report.json -i ERR8774458_1.fastq.gz -I ERR8774458_2.fastq.gz -o trimmed_ERR8774458_1.fastq.gz -O trimmed_ERR8774458_2.fastq.gz

# Move the Trimmed result to Results directory
mv trimmed_ERR8774458_1.fastq.gz trimmed_ERR8774458_2.fastq.gz report.json report.html ~/PROJECT3/Results/

# change the directory to Ref
cd .. && cd Ref

bwa index Reference.fasta 
bwa mem Reference.fasta ~/PROJECT3/Results/trimmed_ERR8774458_1.fastq.gz ~/PROJECT3/Results/trimmed_ERR8774458_2.fastq.gz > ~/PROJECT3/Results/mapped.sam
cd ../
cd .. && cd Results
samtools view -hbo mapped.bam mapped.sam
samtools sort mapped.bam -o mapped.sorted.bam

# Variant Calling
bcftools mpileup -Ou -f ~/PROJECT3/Ref/Reference.fasta mapped.sorted.bam | bcftools call -mv -Ob -o variants.bcf
cd ..
# To view all the Data generated 
ls -lh ~/PROJECT3/Data/ ~/PROJECT3/Ref ~/PROJECT3/Results/


#!/usr/bin/env bash

# Define the URL for the reference genome and the desired filename
ref_url="https://raw.githubusercontent.com/josoga2/yt-dataset/main/dataset/raw_reads/reference.fasta"
ref_name="reference.fasta"

# Download the reference genome if it's not already present
if [ ! -f "$ref_name" ]; then
    echo "Downloading reference genome..."
    wget -O "$ref_name" "$ref_url"
    echo "Downloaded reference genome."
fi
# Define an array of sequence URLs
seq_urls=(
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/ACBarrie_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/ACBarrie_R2.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Alsen_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Alsen_R2.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Baxter_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Baxter_R2.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Chara_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Chara_R2.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Drysdale_R1.fastq.gz"
  "https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/Drysdale_R2.fastq.gz"
)
# Index the reference genome for mapping (if not already indexed)
if [ ! -f "$ref_name".bwt ]; then
    bwa index "$ref_name"
    echo "Indexed reference genome for Genome mapping."
fi

# Loop through each sequence URL
for url in "${seq_urls[@]}"; do
  # Extract the sample name from the URL using cut
  name=$(basename "$url" | cut -d '_' -f 1)
  echo "Sample: $name"

# Download the dataset
  wget -O "${name}_R1.fastq.gz" "$url"
  wget -O "${name}_R2.fastq.gz" "$(dirname "$url")/${name}_R2.fastq.gz"
  echo "Downloaded dataset for $name."  

 # Create directories for quality control and mapping
  mkdir -p "$name"/QCReports
  mkdir -p "$name"/GenMapping
  echo "Created directories for quality control and mapping for $name."
  
# Quality control for both R1 and R2 reads
  fastqc "${name}_R1.fastq.gz" "${name}_R2.fastq.gz" -o "$name"/QC_Reports
  echo "Performed quality control for $name."

# Summarize QC results
  multiqc "$name"/QC_Reports
  echo "Summarized QC results for $name."
  
# Trim using fastp
  fastp --thread 8 --detect_adapter_for_pe --cut_mean_quality 20 --length_required 50 --html report.html --json report.json 
  -i "${name}_R1.fastq.gz" "${name}_R2.fastq.gz" -o "${name}_R1_trimmed.fastq.gz" -O "${name}_R2_trimmed.fastq.gz"
  echo "Trimming done for $name."

# Genome Mapping
  bwa mem "$ref_name" "${name}_R1_trimmed.fastq.gz" "${name}_R2_trimmed.fastq.gz" > "$name"/GenMapping/"$name".sam
  samtools view -@ 20 -S -b "$name"/GenMapping/"$name".sam > "$name"/GenMapping/"$name".bam
  samtools sort -@ 32 -o "$name"/GenMapping/"$name".sorted.bam "$name"/GenMapping/"$name".bam
  samtools index "$name"/GenMapping/"$name".sorted.bam
  echo "Genome mapping done for $name."

# Variant calling using bcftools
  bcftools mpileup -Ou -f "$ref_name" "$name"/GenMapping/"$name".sorted.bam | bcftools call -mv -Ov -o "$name"/"$name".vcf
  echo "Variant calling done for $name."

