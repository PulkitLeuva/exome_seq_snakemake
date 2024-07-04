rule select_snp:
    input:
        vcf=f"{config['vcf_path']}.gatk.vcf",
        ref = f"{config['reference_path']}/{config['names']['reference']}.fa",
    output:
        snp_vcf = report(f"{config['select_snp_path']}.select_snp.vcf",caption = "reports/father.gatk.rst", category = "snp_selection"),
    log: 
        log= f"{config['logs_path']}.select_snp.log",
    params:
        extra="--select-type-to-include SNP",
        filter= "--exclude-filtered"
    priority: 13
    benchmark:
        f"{config['benchmark_path']}_select_snp.tsv"
    message: "Executing select snp variant command on the following files {input}."
    shell:
        "gatk SelectVariants --variant {input.vcf} --reference {input.ref} {params.extra} {params.filter} --output {output.snp_vcf} > {log}"

        