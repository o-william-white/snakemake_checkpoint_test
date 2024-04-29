rule getorganelle:
    input:
        fwd=rules.fastp_pe.output.trimmed[0],
        rev=rules.fastp_pe.output.trimmed[1],
    params:
        seed=get_seed,
        gene=get_gene,
    output:
        directory("results/getorganelle/{sample}/"),
    log:
        "logs/getorganelle/{sample}.log",
    conda:
        "../envs/getorganelle.yaml"
    shell:
        """
        get_organelle_from_reads.py \
            -1 {input.fwd} \
            -2 {input.rev} \
            -o results/getorganelle/{wildcards.sample} \
            -F animal_mt \
            -s {params.seed} \
            --genes {params.gene} \
            --reduce-reads-for-coverage inf \
            --max-reads inf \
            -R 20 \
            --overwrite &> {log}
        """
