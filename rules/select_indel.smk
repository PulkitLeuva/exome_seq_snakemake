rule select_indel:
    input:
        vcf=f"{config['vcf_path']}.gatk.vcf",
        ref = f"{config['reference_path']}/{config['names']['reference']}.fa",
    output:
        indel_vcf = f"{config['select_indel_path']}.select_indel.vcf", 
    log: 
        log= f"{config['logs_path']}.select_indel.log",
    params:
        extra= "--select-type-to-include INDEL",
        filter= "--exclude-filtered"
    priority: 14
    benchmark:
        f"{config['benchmark_path']}_select_indel.tsv"
    message: "Executing select indel variant command on the following files {input}."

    shell:
        "gatk SelectVariants --variant {input.vcf} --reference {input.ref} {params.extra} {params.filter} --output {output.indel_vcf} > {log}"

        