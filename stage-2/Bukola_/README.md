
**NGS Analysis Pipeline**
This pipeline is designed to automate the process of downloading sequencing data, performing quality control, trimming, mapping to a reference genome, and variant calling using the provided script. The script is written in Bash and utilizes various bioinformatics tools such as wget, fastqc, multiqc, fastp, bwa, samtools, and bcftools.

**Set Up Environment**: Ensure that you have the necessary tools installed on your system. You will need:
wget
fastqc
multiqc
fastp
bwa
samtools
bcftools

**Modify Script**: Before running the script, make sure to modify the following variables in the script according to your requirements:

ref_url: URL for the reference genome.
ref_name: Desired filename for the reference genome.
seq_urls: Array of sequence URLs.
Run Script: Execute the script by running the following command in the terminal: ./script.sh

**Output**
The script will perform the following steps for each sequence:

Download the reference genome.
Download the sequencing data from the provided URLs.
Perform quality control using fastqc.
Summarize QC results using multiqc.
Trim the sequencing data using fastp.
Index the reference genome using bwa.
Map the trimmed reads to the reference genome using bwa mem.
Convert SAM to BAM format using samtools.
Sort and index the BAM file using samtools.
Perform variant calling using bcftools.
The output files will be organized into directories for each sample containing quality control reports (QCReports) and mapped reads (GenMapping). Variant calling results will be stored as VCF files.

**Dependencies**
wget: For downloading files from URLs.
fastqc: For quality control analysis of sequencing data.
multiqc: For summarizing quality control reports.
fastp: For trimming sequencing reads.
bwa: For mapping reads to the reference genome.
samtools: For manipulating SAM/BAM files.
bcftools: For variant calling from mapped reads.
