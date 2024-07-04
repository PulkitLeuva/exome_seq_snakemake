rule mean_quality_by_cycle:
    input:
        bam= f"{config['sorted_path']}.sorted.bam",
        ref = f"{config['reference_path']}/{config['names']['reference']}.fa",

    output:
        chart =f"{config['mean_quality_by_cycle_path']}.mean_quality_by_cycle.pdf",
        metrics=f"{config['mean_quality_by_cycle_path']}.mean_quality_by_cycle.txt",
    log:
        log = f"{config['logs_path']}.mean_quality_by_cycle.log",
    priority: 8
    benchmark:
        f"{config['benchmark_path']}_mean_quality_by_cycle.tsv"
    shell:
        """
        gatk MeanQualityByCycle -I {input.bam} -R {input.ref} -O {output.metrics} -CHART {output.chart}  > {log}
        """