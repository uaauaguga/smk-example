# smk-example

`run/simulate.py` generate 4 random genome, and sampling reads with length of 20nt from these genomes

`run/build.sh` build bowtie2 index for the random generated genome

`Snakemake` map simulated reads back to the random generated index, and sort the bam file
