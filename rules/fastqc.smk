rule fastqc:
    input:
        fastq1 = f"{config['sample_path']}_R1.fq",
        fastq2 = f"{config['sample_path']}_R2.fq",
    output:
        html_report1 = f"{config['fastqc_path']}_R1_fastqc.html",
        zip1 = f"{config['fastqc_path']}_R1_fastqc.zip",
        html_report2 = f"{config['fastqc_path']}_R2_fastqc.html",
        zip2 = f"{config['fastqc_path']}_R2_fastqc.zip",

    log:
        log= f"{config['logs_path']}.fastqc.log",
    #conda: "envs/fastqc.yaml"  # Use a conda environment with FastQC installed
    params:
        outdir='output/{sample}/qc/fastqc' #asolute path is written because {sample} wildcard cant be detected if used confi['']
    benchmark:
        f"{config['benchmark_path']}_fastqc.tsv"
    
    message: "Executing fastqc on the following files {input}."
    priority: 1
    shell:
        """
        fastqc --outdir {params.outdir} {input} > {log}
        """

#we dont need to specify the output file name snakemake will automatically  name the output files by taking the original filename, removing the .fastq extension, and replacing the extension with _fastqc.html or _fastqc.zip.
# but we need to specify the outut directory