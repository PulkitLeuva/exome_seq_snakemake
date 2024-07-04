rule collect_variant_calling_metrics_gatk:
    input:
        vcf=f"{config['vcf_path']}.gatk.vcf",
        dbsnp=f"{config['dbsnp_path']}/{config['names']['dbsnp']}.vcf",
        ref_dict = f"{config['reference_path']}/{config['names']['reference']}.dict",
        ref=f"{config['reference_path']}/{config['names']['reference']}.fa",
        #TI = "/lustre/pulkit.h/snakemake_local/snakemake/input/chr8.list",
    output:
        metrics=f"{config['variant_calling_metrics_path']}.variant_calling_metrics.txt",
    log:
        log=f"{config['logs_path']}.collect_variant_calling_metrics_gatk.log",
    params:
        extra="",  # optional
        java_opts="",  # optional
    benchmark:
        f"{config['benchmark_path']}_collect_variant_calling_metrics_gatk.tsv"
    message: "Executing gatk CollectVariantCallingMetrics on the following files {input}."
    threads: 4
    resources:
        mem_mb=1024,
    #priority: 13
    shell:
        """
        
        
        gatk CollectVariantCallingMetrics -I {input.vcf} -O {output.metrics} -R {input.ref} --DBSNP {input.dbsnp} --SEQUENCE_DICTIONARY {input.ref_dict} > {log}
        """
#gatk CreateSequenceDictionary -R {input.ref} -O /lustre/pulkit.h/snakemake_local/snakemake/input/dbsnp/dbsnp.dict
#gatk IndexFeatureFile -I {input.dbsnp}
