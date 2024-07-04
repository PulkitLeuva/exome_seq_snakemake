# the mapped reads are sorted in the rule, it takles bam file and gives the sorted bam file 
rule samtools_sort:
    input:
        bam= f"{config['dedup_path']}.dedup.bam", 
    output:
        sorted= f"{config['sorted_path']}.sorted.bam"
    log:
        log = f"{config['logs_path']}.samtools_sort.log",
    
    message: "Executing samtools sorting command on the following files {input}."
    priority: 4
    benchmark:
        f"{config['benchmark_path']}_samtools_sort.tsv"
    shell:
        "(samtools sort -O bam {input} > {output}) 2> {log}"
        #(samtools sort -T sorted_reads/{sample} -O bam {input} > {output}) 2> {log.real}