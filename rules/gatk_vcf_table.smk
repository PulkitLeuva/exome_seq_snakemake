rule gatk_vcf_table:
    input:
        vcf=f"{config['vcf_path']}.gatk.vcf",
    output:
        table= f"{config['gatk_vcf_table_path']}.table",
    log:
        logs= f"{config['logs_path']}.vcf_table.log",
    benchmark:
        f"{config['benchmark_path']}_gatk_vcf_table.tsv"
    shell:
        "gatk VariantsToTable -V {input.vcf} -F CHROM -F POS -F TYPE -F DP -F QD -O {output.table}"
