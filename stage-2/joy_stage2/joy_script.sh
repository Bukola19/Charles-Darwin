
#task1
#pipeline for a pair read sample 
#!/bin/bash
source ~/anaconda3/etc/profile.d/conda.sh
conda activate joy_stage2

#set up various directories for the output
mkdir data data/fastq data/ref BAMS SAM VCF data/fastq/trimmed_reads

#downloading datasets using wget
wget -P data/fastq https://zenodo.org/records/10426436/files/ERR8774458_1.fastq.gz \
                   https://zenodo.org/records/10426436/files/ERR8774458_2.fastq.gz
#to check the downloaded data size and content
ls -lh

#to perform fastqc for the datasets
fastqc data/fastq/*.fastq.gz


#to trim the fastq files
fastp  -i data/fastq/ERR8774458_1.fastq.gz -I data/fastq/ERR8774458_2.fastq.gz -o data/fastq/trimmed_reads/ERR8774458_1.fastq.gz -O data/fastq/trimmed_reads/ERR8774458_2.fastq.gz --html data/fastq/trimmed_reads/ERR8774458_fastp.html --json data/fastq/trimmed_reads/ERR8774458_fastp.json


#to index the reference genome for mapping using bwa

bwa index -a bwtsw data/ref/Reference.fasta


# to map the trimmed fastq files  to a reference genome using bwa

ref=data/ref/Reference.fasta
read1=data/fastq/trimmed_reads/ERR8774458_1.fastq.gz
read2=data/fastq/trimmed_reads/ERR8774458_2.fastq.gz

bwa mem $ref $read1 $read2 > SAM/ERR8774458.sam

# to convert the SAM file into a BAM file that can be sorted and indexed
samtools view -hbo BAMS/ERR8774458.bam SAM/ERR8774458.sam 

# to sort the BAM file in genome
samtools sort BAMS/ERR8774458.bam -o BAMS/ERR8774458.sorted.bam

# to  index the the sorted files
samtools index BAMS/ERR8774458.sorted.bam


# to use bcftools call the variant calling

bcftools mpileup -Ou -f $ref BAMS/ERR8774458.sorted.bam|bcftools call -Ov -mv > VCF/ERR8774458.vcf


#task2

#!/bin/bash
#loop_script for ngs pipeline
mkdir -p data
Data_dir="data"
SAMPLES=(
    "ACBarrie"
    "Alsen"
    "Baxter"
    "Chara"
    "Drysdale"
)

#to download the datasets 
for sample in "${SAMPLES[@]}";do
    read1_url="https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/${sample}_R1.fastq.gz"
    read2_url="https://github.com/josoga2/yt-dataset/raw/main/dataset/raw_reads/${sample}_R2.fastq.gz"
    
    wget -P "${Data_dir}" "$read1_url"
    wget -P "${Data_dir}" "$read2_url" 
done

ref_url="https://raw.githubusercontent.com/josoga2/yt-dataset/main/dataset/raw_reads/reference.fasta"
wget -P "${Data_dir}" "$ref_url"

#to perform the quality control using fastqc
mkdir -p fastqc_out
for fq in "${Data_dir}"/*.fastq.gz;do
    #fastqc -i "${fq}" -o fastqc_out
    fastqc -f fastq -o fastqc_out "${fq}"
done

#to perform trimming using the fastp
for fastq in "${SAMPLES[@]}";do
    read1="${Data_dir}/${fastq}_R1.fastq.gz"
    read1_out="${Data_dir}/${fastq}_R1.trimmed.fastq.gz"
    read2="${Data_dir}/${fastq}_R2.fastq.gz"
    read2_out="${Data_dir}/${fastq}_R2.trimmed.fastq.gz"
    fastp -i "${read1}" -o "${read1_out}" -I "${read2}" -O "${read2_out}"
done

#to perform genome mapping with the reference fasta using bwa
reference="${Data_dir}/reference.fasta"
bwa index -a bwtsw "${reference}"
mkdir -p bwa_outputfile
for map in "${SAMPLES[@]}"; do
    read1="${Data_dir}/${map}_R1.trimmed.fastq.gz"
    read2="${Data_dir}/${map}_R2.fastq.gz"
    bwa_result="bwa_outputfile/${map}.sam"
    bwa mem "${reference}" "${read1}" "${read2}" > "${bwa_result}"
    samtools view -hbo "bwa_outputfile/${map}.bam" "bwa_outputfile/${map}.sam"
    samtools sort "bwa_outputfile/${map}.bam" -o "bwa_outputfile/${map}.sorted.bam"
    samtools index "bwa_outputfile/${map}.sorted.bam"
done

#to perform the variant calling using the bcftools
mkdir -p bcf_outputfile
for bcf in "${SAMPLES[@]}"; do
    bcftools mpileup -Ou -f "${reference}" "bwa_outputfile/${bcf}.sorted.bam" | bcftools call -Ov -mv > "bcf_outputfile/${bcf}.vcf"
done
