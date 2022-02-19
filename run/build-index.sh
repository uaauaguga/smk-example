#!/bin/bash
for i in {0..3};do
  bowtie2-build genome/fasta/${i}.fa genome/bt2-idx/$i
done
