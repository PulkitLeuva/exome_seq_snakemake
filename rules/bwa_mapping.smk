rule bwa_mapping:
    input:
        reference= f"{config['reference_path']}/{config['names']['reference']}.fa",
        fastq1 = f"{config['sample_path']}_R1.fq",
        fastq2 = f"{config['sample_path']}_R2.fq",
    output:
        bam = f"{config['mapped_path']}.mapped.bam"
    log:
        log_file = f"{config['logs_path']}.bwa_map.log"
    benchmark:
        f"{config['benchmark_path']}_mapping.tsv"
    params:
        rg = r'@RG\\tID:{sample}\\tSM:{sample}\\tPL:ILLUMINA\\tLB:LIB-A',  # Note the double backslashes // add {sample} inplace of father
        algo2 = config["mapping_params"]["algo"]
    message: "Executing bwa mapping command on the following files {input}."
    threads: 4
    priority: 2
    shell:
        "(bwa {params.algo2} -R {params.rg} -t {threads} {input.reference} {input.fastq1} {input.fastq2} | "
        "samtools view -Sb - > {output.bam}) 2> {log.log_file}"