rule bedtools_genomcov:
    input:
        bam= f"{config['sorted_path']}.sorted.bam",
        ref = f"{config['reference_path']}/{config['names']['reference']}.fa",
    output:
        coverage=f"{config['bedtools_genomcov_path']}.bedtools.bedgraph", 
    log:
        f"{config['logs_path']}.genomcov.log",
    priority: 10
    benchmark:
        f"{config['benchmark_path']}_bedtools_genomcov.tsv"
    shell:
        "bedtools genomecov -ibam {input.bam} -g {input.ref} > {output.coverage} 2> {log}"
#sudo apt install bedtools 