# How to run the pipeline
1. Confirm that you meet up with the system requirement; check `requirement.txt`
2. Navigate to your desired working directory
3. Execute the setup file (`setup.sh`) by running the command `bash setup.sh`
4. Follow the screen prompt and press **yes** or **y** where required
5. Run `conda activate bioenv` to activate the setup environment
6. Execute `script.sh` by running the command `bash script.sh` to run your pipeline

## You should end up with the following sub directories and files
- data: data/fastq, data/ref
- BAM
- VCF
- multiqc_data
- multiqc_report.html
