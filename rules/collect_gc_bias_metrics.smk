rule collect_gc_bias_metrics:
    input:
        bam= f"{config['sorted_path']}.sorted.bam",
        ref = f"{config['reference_path']}/{config['names']['reference']}.fa",
    output:
        metrics= f"{config['collect_gc_bias_metrics_path']}.gc_bias_metrics.txt",
        chart = f"{config['collect_gc_bias_metrics_path']}.gc_bias_metrics.pdf",
        summary = f"{config['collect_gc_bias_metrics_path']}.gc_bias_metrics_summary_metrics.txt",
    log:
        log= f"{config['logs_path']}.collect_gc_bias_metrics.log",
    priority: 7
    benchmark:
        f"{config['benchmark_path']}_collect_gc_bias_metrics.tsv"
    shell:
        """
        gatk CollectGcBiasMetrics -I {input.bam} -R {input.ref} -O {output.metrics} -CHART {output.chart} -S {output.summary} > {log}
        """   