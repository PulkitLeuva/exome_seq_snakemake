rule collect_insert_size_metrics:
    input:
        bam= f"{config['sorted_path']}.sorted.bam",
        ref = f"{config['reference_path']}/{config['names']['reference']}.fa",
    output:
        metrics=f"{config['collect_insert_size_metrics_path']}_collect_insert_size_metrics.txt",
        histo = f"{config['collect_insert_size_metrics_path']}_collect_insert_size_metrics_histogram.pdf", 
    params:
        qc_params = config["qc_params"]["collect_insert_size_metrics"]["extra"]
    benchmark:
        f"{config['benchmark_path']}_collect_insert_size_metrics.tsv"
    log:
        log= f"{config['collect_insert_size_metrics_path']}.collect_collect_insert_size_metrics.log",
    shell:
        """
        gatk CollectInsertSizeMetrics -I {input.bam} -O {output.metrics} -H {output.histo} > {log}
        """     

# file is not generating
#WARNING 2023-08-24 11:15:11     SinglePassSamProgram    File reports sort order 'unsorted', assuming it's coordinate sorted anyway.
#WARNING 2023-08-24 11:15:11     CollectInsertSizeMetrics        All data categories were discarded because they contained < 0.05 of the total aligned paired data.
#WARNING 2023-08-24 11:15:11     CollectInsertSizeMetrics        Total mapped pairs in all categories: 0.0