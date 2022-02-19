#!/usr/bin/env python

from random import randint

def get_random_string(length=10000):
    alphabets = "ACGT"
    s = ""
    for i in range(length):
        s += alphabets[randint(0,3)]
    return s


def main():
    seqs = []
    for i in range(5):
        with open(f"genome/{i}.fa","w") as f:
            f.write(f">genome-{i}\n")
            s = get_random_string()
            seqs.append(s)
            f.write(f"{s}\n")
    print("sample_id\tgenome_id")
    for j in range(64):
        sample_id = str(j).zfill(4)
        genome_idx = randint(0,3)
        s = seqs[genome_idx]
        print(f"{sample_id}\t{genome_idx}")
        with open(f"data/{sample_id}.fa","w") as f:
            for k in range(5000):
                f.write(f">{k}\n")
                start = randint(0,9990)
                end = start + 10
                f.write( s[start:end] + "\n")

        




if __name__ == "__main__":
    main()
