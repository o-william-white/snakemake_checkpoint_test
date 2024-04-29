def get_assembled_samples(wildcards):
    ck_output = checkpoints.assembled_sequence.get(**wildcards).output[0]
    return expand(
        rules.seqkit.output,
        sample=glob_wildcards(os.path.join(ck_output, "{sample}.fasta")).sample,
    )

rule final_report:
    input:
        get_assembled_samples
    output:
        "results/report.txt"
    shell:
        """
            for f in {input};
            do
                echo  $f >> {output}
            done
        """

