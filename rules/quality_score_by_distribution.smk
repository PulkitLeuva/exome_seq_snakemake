rule quality_score_by_distribution:
    input:
        bam= f"{config['sorted_path']}.sorted.bam",
        ref = f"{config['reference_path']}/{config['names']['reference']}.fa",

    output:
        chart = f"{config['quality_score_by_distribution_path']}.quality_score_by_distribution.pdf", 
        metrics=f"{config['quality_score_by_distribution_path']}.quality_score_by_distribution.txt",
    log:
        log= f"{config['logs_path']}.quality_score_by_distribution.log",
    priority: 9
    message: "Executing quality score by distribution command on the following files {input}."
    benchmark:
        f"{config['benchmark_path']}_quality_score_by_distribution.tsv"
    shell:
        """
        gatk QualityScoreDistribution -I {input.bam} -R {input.ref} -O {output.metrics} -CHART {output.chart}  > {log}
        """

#MissingOutputException in rule mean_quality_by_cycle in file /lustre/pulkit.h/code/experimentscripts/ex_seq_snakemake/rules/mean_quality_by_cycle.smk, line 1:
#Job 8  completed successfully, but some output files are missing. Missing files after 5 seconds. This might be due to filesystem latency. If that is the case, consider to increase the wait time with --latency-wait:
#/lustre/pulkit.h/code/experimentscripts/ex_seq_snakemake/output/qc/mean_quality_by_cycle/sub.mean_quality_by_cycle.pdf