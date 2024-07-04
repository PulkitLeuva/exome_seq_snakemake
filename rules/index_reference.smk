import time

start_time1 = time.time()

rule index_reference:
    input:
        ref= f"{config['reference_path']}/{config['names']['reference']}.fa",
        dbsnp=f"{config['dbsnp_path']}/{config['names']['dbsnp']}.vcf", 
    output:
        bwt= f"{config['reference_path']}/{config['names']['reference']}.fa.bwt",
        #ref_dict= f"{config['reference_path']}/{config['names']['reference']}.dict",
        fai= f"{config['reference_path']}/{config['names']['reference']}.fa.fai",
    log:
        log= f"/lustre/pulkit.h/snakemake_local/snakemake/logs/ref/{config['names']['reference']}.log",
    benchmark:
        f"/lustre/pulkit.h/snakemake_local/snakemake/benchmark/ref/{config['names']['reference']}.tsv",
    shell:
        """
        (bwa index {input.ref}) 2> {log} 
        gatk CreateSequenceDictionary -R {input.ref}
        samtools faidx {input.ref}
        gatk IndexFeatureFile -I {input.dbsnp}
        """

end_time1 = time.time()

elapsed_time1 = end_time1 - start_time1
print(f"Workflow completed in {elapsed_time1:.2f} seconds.")