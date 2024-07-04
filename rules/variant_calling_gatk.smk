rule variant_calling_gatk:
    input:
        # single or list of bam files
        bam= f"{config['sorted_path']}.sorted.bam",
        ref = f"{config['reference_path']}/{config['names']['reference']}.fa",
        bai= f"{config['sorted_path']}.sorted.bam.bai",
       
        # known="dbsnp.vcf"  # optional
    output:
        vcf= ensure(f"{config['vcf_path']}.gatk.vcf", non_empty=True),
    #       bam="{sample}.assemb_haplo.bam",
    log:
        log = f"{config['logs_path']}.vcf_gatk.log",
    params:
        interval = ["chr8"]
    benchmark:
        f"{config['benchmark_path']}_variant_calling_gatk.tsv"
    message: "Executing gatk haplotylecaller with {threads} threads on the following files {input}."
    threads: 4
    resources:
        mem_mb=1024,
    priority: 11
    shell:
        "gatk HaplotypeCaller --native-pair-hmm-threads {threads} --input {input.bam} --reference {input.ref} --output {output.vcf} > {log}"