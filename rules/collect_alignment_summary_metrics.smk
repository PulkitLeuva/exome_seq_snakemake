rule collect_alignment_summary_metrics:
    input:
        bam= f"{config['sorted_path']}.sorted.bam",
        ref = f"{config['reference_path']}/{config['names']['reference']}.fa",

    output:
        metrics=f"{config['collect_alignment_summary_metrics_path']}.alignment_summary_metrics.txt",
    log:
        log= f"{config['logs_path']}.collect_alignment_summary_metrics.log",
    priority: 6
    benchmark:
        f"{config['benchmark_path']}_collect_alignment_summary_metrics.tsv"
    shell:
        """
        gatk CollectAlignmentSummaryMetrics -I {input.bam} -R {input.ref} -O {output.metrics} > {log}
        """