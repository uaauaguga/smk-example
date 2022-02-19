
sample_id2genome_id = {}

with open("table.txt") as f:
    _ = next(f)
    for line in f:
        sample_id, genome_id = line.strip().split("\t")
        sample_id2genome_id[sample_id] = genome_id
sample_ids = list(sample_id2genome_id.keys())


rule all:
    input:
        bam = expand("output/bam.sorted/{sample_id}.bam",sample_id=sample_ids)


def get_bt2_prefix(wildcards):
    genome_idx = sample_id2genome_id[wildcards.sample_id]
    return f"genome/bt2-idx/{genome_idx}"

def get_bt2_idx(wildcards):
    genome_idx = sample_id2genome_id[wildcards.sample_id]
    indices = []
    for c in ["1","2","3","4","rev.1","rev.2"]:
        path = f"genome/bt2-idx/{genome_idx}.{c}.bt2"
        indices.append(path)
    return indices

rule mapping:
    input:
        fasta = "data/{sample_id}.fa",
        bt2_idx = get_bt2_idx
    output:
        bam = "output/bam/{sample_id}.bam" 
    params:
        bt2_idx = get_bt2_prefix
    log: "log/mapping/{sample_id}.txt"
    shell:
        """
        bowtie2 -f -x {params.bt2_idx} -U {input.fasta} 2> {log} | samtools view -b  > {output.bam} 
        """

rule sort:
    input:
        bam = "output/bam/{sample_id}.bam"
    output:
        sorted = "output/bam.sorted/{sample_id}.bam",
        idx = "output/bam.sorted/{sample_id}.bam.bai"
    shell:
        """
        samtools sort {input.bam} > {output.sorted}
        samtools index {output.sorted}
        """
