rule variant_eval_gatk:
    input:
        vcf=f"{config['vcf_path']}.gatk.vcf",
        dbsnp=f"{config['dbsnp_path']}/{config['names']['dbsnp']}.vcf",  # Provide the path to the dbSNP VCF file
        ref=f"{config['reference_path']}/{config['names']['reference']}.fa",
    output:
        eval_report=(f"{config['eval_path']}.variant_eval.txt"),
    log:
        log=f"{config['logs_path']}.variant_eval_gatk.log",
    params:
        extra="",  # optional
        java_opts="",  # optional
    benchmark:
        f"{config['benchmark_path']}_variant_eval_gatk.tsv"
    message: "Executing gatk VariantEval on the following files {input}."
    threads: 4
    resources:
        mem_mb=1024,
    #priority: 12
    shell:
        "gatk VariantEval --eval {input.vcf} --dbsnp {input.dbsnp} --reference {input.ref} --eval-module VariantSummary --eval-module CountVariants --output {output.eval_report} 2> {log}"
