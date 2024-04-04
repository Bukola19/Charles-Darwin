# Project: NGS Pipeline
This project contains a Bash script designed to download sequencing data, performs quality control, trims sequences, maps the genome, and calls variants.

**Prerequisites**

Make sure you have the following programs installed on your system before running the script:

* wget for downloading data files.
+ fastp for quality control and sequence trimming.
- bwa for genome mapping.
+ samtools for handling SAM and BAM files.
* bcftools for variant calling.

**Usage**

***Clone this repository to your system:***

git clone https://github.com/Bukola19/Charles-Darwin/tree/96c794aed65362f1ebf563ca1062818acbcd27b8/stage-2/Abner

***Navigate to the project directory:***

cd Abner

***Run the bash script:***

bash script.sh

***The script will perform the following actions:***

1. Data Download: Download DNA sequencing data files and a reference genome from a remote repository.

2. Quality Control and Trimming: Use fastqc to perform quality control and then fastp for trimming of DNA sequences.

3. Genome Mapping: Use bwa to map the trimmed DNA sequences to the reference genome.

4. Variant Calling: Use bcftools to call variants from the mapped files.

**Project Structure**

script.sh: The main script that automates the NGS pipeline.

data/: Directory to store downloaded data files, reference genome and trimmed fastq.gz files.

fastqc_out/: Directory to store quality control results.

bwa_output/: Directory to store output files from genome mapping.

bcf_output/: Directory to store output files from variant calling.
