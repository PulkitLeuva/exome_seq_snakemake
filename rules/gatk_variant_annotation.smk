rule variant_annotation_gatk:
    input:
        vcf=f"{config['vcf_path']}.gatk.vcf",
        dbsnp=f"{config['dbsnp_path']}/{config['names']['dbsnp']}.vcf",
        ref=f"{config['reference_path']}/{config['names']['reference']}.fa",
    output:
        out=f"{config['gatk_variant_annotation_path']}.gatk_variant_annotation.vcf",
    log:
        log=f"{config['logs_path']}.gatk_variant_annotation_gatk.log",
    params:
        extra="",  # optional
        java_opts="",  # optional
    benchmark:
        f"{config['benchmark_path']}_gatk_variant_annotation_gatk.tsv"
    message: "Executing gatk CollectVariantCallingMetrics on the following files {input}."
    threads: 4
    resources:
        mem_mb=1024,
    #priority: 13
    shell:
        """
        gatk VariantAnnotator \
        -V {input.vcf} \
        -R {input.ref} \
        --dbsnp {input.dbsnp} \
        -A Coverage \
        -O {output.out} &> {log}

        """
#we have used -L flag in the command to specfically use chr 8 interval , because we are using chr 8 seq as reference
# -L chr8 \