rule indel_filter:
    input:
        vcf=f"{config['vcf_path']}.gatk.vcf",
        ref = f"{config['reference_path']}/{config['names']['reference']}.fa",
#        intervals="targets.bed",
    output:
        vcf=f"{config['indel_filter_path']}.indel.filtered.vcf",
    log:
        log =f"{config['logs_path']}.indel_filter.log",
    priority: 16
    benchmark:
        f"{config['benchmark_path']}_indel_filter.tsv"
    resources:
        mem_mb=1024,
    shell:
        """
        gatk VariantFiltration \
        -V {input.vcf} \
        --reference {input.ref} \
        -filter "QD < 2.0" --filter-name "QD2" \
        -filter "QUAL < 30.0" --filter-name "QUAL30" \
        -filter "FS > 200.0" --filter-name "FS200" \
        -filter "ReadPosRankSum < -20.0" --filter-name "ReadPosRankSum-20" \
        -O {output.vcf}
        
        """