# to index the sorted bam file
rule samtools_index:
    input:
        sorted= f"{config['sorted_path']}.sorted.bam",
    output:
        indexed= f"{config['sorted_path']}.sorted.bam.bai",
    #conda:
       # "envs/samtools.yaml" #define isolated software environments per rule
    log:
        log= f"{config['logs_path']}.samtools_index.log",
    message: "Executing samtools indexing command on the following files {input}."
    benchmark:
        f"{config['benchmark_path']}_samtools_index.tsv"
    priority: 5
    shell:
        """
        (samtools index {input} > {output}) 2> {log}

        """