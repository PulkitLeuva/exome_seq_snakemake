rule snp_filter:
    input:
        vcf=f"{config['vcf_path']}.gatk.vcf",
        ref = f"{config['reference_path']}/{config['names']['reference']}.fa",
#        intervals="targets.bed",
    output:
        vcf= f"{config['snp_filter_path']}.snp.filtered.vcf",
    log:
        logs= f"{config['logs_path']}.snp_filter.log",
    priority: 15
    benchmark:
        f"{config['benchmark_path']}_snp_filter.tsv"
    message: "Executing snp filteration command on the following files {input}."
    resources:
        mem_mb=1024,
    shell:
        """
        gatk VariantFiltration \
        -V {input.vcf} \
        --reference {input.ref} \
        -filter "QD < 2.0" --filter-name "QD2" \
        -filter "QUAL < 30.0" --filter-name "QUAL30" \
        -filter "SOR > 3.0" --filter-name "SOR3" \
        -filter "FS > 60.0" --filter-name "FS60" \
        -filter "MQ < 40.0" --filter-name "MQ40" \
        -filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
        -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
        -O {output.vcf}
        
        """