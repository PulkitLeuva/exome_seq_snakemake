rule bcftools_stats:
    input:
        vcf=f"{config['vcf_path']}.gatk.vcf",
    output:
        stats=f"{config['bcftools_stats_path']}.vcf_stats.txt",
    log:
        logs= f"{config['logs_path']}.vcf_stats.log",
    benchmark:
        f"{config['benchmark_path']}_bcftools_stats.tsv"
    priority: 12
    #conda: 
      #  "bcftools_env"
    shell:
        "bcftools stats {input.vcf} > {output.stats} 2> {log}"
'''
rule vcf_stats_graph:
    input:
        vcf_stat= f"{config['bcftools_stats_path']}.vcf_stats.txt",
    shell:
        "plot-vcfstats {input}"
'''
#because the bcftools in main env(snakemake) was not working and also reinstalling was not possible I created another env(bcftools_env) and installed bcftools in it and used it here.