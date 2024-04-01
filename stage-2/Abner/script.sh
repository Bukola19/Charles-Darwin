#!/bin/bash

# Rule to download datasets
rule download_data:
    output:
        read1="/home/fridayv/NGS_analysis/forward.fastq.gz",
        read2="/home/fridayv/NGS_analysis/reverse.fastq.gz",
        ref="/home/fridayv/NGS_analysis/reference.fasta"
    params:
        read1_url="https://zenodo.org/records/10426436/files/ERR8774458_1.fastq.gz?download=1",
        read2_url="https://zenodo.org/records/10426436/files/ERR8774458_2.fastq.gz?download=1",
        ref_url="https://zenodo.org/records/10886725/files/Reference.fasta?download=1"
    shell:
        """
        wget -O {output.read1} {params.read1_url}
        wget -O {output.read2} {params.read2_url}
        wget -O {output.ref} {params.ref_url}
        """
 #Rule to unzip reads files
rule unzip_reads:
    input:
        forward="forward.fastq.gz",
        reverse="reverse.fastq.gz"
    output:
        forward_uncompressed="forward.fastq",
        reverse_uncompressed="reverse.fastq"
    shell:
        "gunzip -c {input.forward} > {output.forward_uncompressed} && "
        "gunzip -c {input.reverse} > {output.reverse_uncompressed}"   

# Rule for quality control with FastQC
rule fastqc:
    input:
        read1="/home/fridayv/NGS_analysis/forward.fastq",
        read2="/home/fridayv/NGS_analysis/reverse.fastq"
    output:
        fastqc_dir="fastqc_out",
        fastqc_files=expand("fastqc_out/{sample}.{ext}", sample=['forward.fastq.gz', 'reverse.fastq.gz'], ext=["html", "zip"])
    shell:
        """
        mkdir -p {output.fastqc_dir}
        fastqc {input.read1} -o {output.fastqc_dir}
        fastqc {input.read2} -o {output.fastqc_dir}
        """
# Rule for trimming with FastP
rule fastp:
    input:
        forward="forward.fastq",
        reverse="reverse.fastq"
    output:
        trimmed_forward="fastp_out/forward_trimmed.fastq",
        trimmed_reverse="fastp_out/reverse_trimmed.fastq",
        unpaired_forward="fastp_out/forward_unpaired.fastq",
        unpaired_reverse="fastp_out/reverse_unpaired.fastq",
        html_report="fastp_out/report.html"
    params:
        extra=""
    threads: 1
    shell:
        """
        mkdir -p fastp_out && \\
        fastp --in1 {input.forward} --in2 {input.reverse} \\
              --out1 {output.trimmed_forward} --out2 {output.trimmed_reverse} \\
              --unpaired1 {output.unpaired_forward} --unpaired2 {output.unpaired_reverse} \\
              --html {output.html_report} \\
              {params.extra}
        """

# Rule for genome mapping with BWA

rule bwa_map:
    input:
        ref="/home/fridayv/NGS_analysis/reference.fasta",
        forward="/home/fridayv/NGS_analysis/fastp_out/forward_trimmed.fastq",
        reverse="/home/fridayv/NGS_analysis/fastp_out/reverse_trimmed.fastq"
    output:
        forward="mapped_reads/forward.bam",
        reverse="mapped_reads/reverse.bam"
    shell:
        """
        bwa index {input.ref}
        bwa mem -t 1 {input.ref} {input.forward} {input.reverse} | samtools view -Sb - > {output.forward}
        bwa mem -t 1 {input.ref} {input.reverse} {input.forward} | samtools view -Sb - > {output.reverse}
        """
# Rule for variant calling with BCFtools
rule bcftools_call:
    input:
        forward="mapped_reads/forward.bam",
        reverse="mapped_reads/reverse.bam",
        reference="/home/fridayv/NGS_analysis/reference.fasta"
    output:
       bcf_out= "bcf_out/variants.vcf"
    shell:
        """
        bcftools mpileup -f {input.forward} {input.reverse} {input.reference} | bcftools call -mv -o {output.bcf_out}
        """
