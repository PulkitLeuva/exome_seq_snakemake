rule mark_duplicates_spark:
    input:
        bam=f"{config['mapped_path']}.mapped.bam",
    output:
        bam=f"{config['dedup_path']}.dedup.bam", 
        metrics=f"{config['dedup_path']}.dedup.metrics.txt",
    log:
        log= f"{config['logs_path']}.dedup.log",
    params:
        extra="--remove-sequencing-duplicates",
    priority: 3
    benchmark:
        f"{config['benchmark_path']}_collect_insert_size_metrics.tsv"
    resources:
        # Memory needs to be at least 471859200 for Spark, so 589824000 when
        # accounting for default JVM overhead of 20%. We round round to 650M.
        mem_mb=lambda wildcards, input: max([input.size_mb * 0.25, 650]),
    threads: 8
    
    shell:
        "gatk MarkDuplicatesSpark --input {input} {params.extra} --output {output.bam} --metrics-file {output.metrics} > {log}"