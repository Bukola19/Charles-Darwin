# How to run the pipeline
1. Confirm that you meet up with the system requirement; check **_requirement.txt_**
2. Head to the terminal and clone the repository

   `git clone https://github.com/Bukola19/Charles-Darwin.git`
  
4. cd into the repository and navigate to the file directory

   `cd Charles-Darwin/stage-2/tiamiyu`

6. Execute the setup file (_setup.sh_) by running the command
   
   `bash setup.sh`

7. Follow the screen prompt and press **yes** or **y** where required
8. Execute _script.sh_ to run the pipeline

   `bash script.sh`

## You should end up with the following subdirectories and files
- BAMS
- SAM
- VCF
- data: data/fastq, data/ref data/fastq/trimmed_reads
- multiqc_data
- multiqc_report.html

# How to run the pipeline on entirely different data
- Locate the **ref_url** variable in `script.sh` and edit to your new reference genome URL
- Locate the **data_url** variable in `script.sh` and edit to your new genome strands URL
     - It works well on either one or multiple genome sequences
     - Remember to separate each URL with a white space
