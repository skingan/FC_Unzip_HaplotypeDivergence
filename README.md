# FC_Unzip_HaplotypeDivergence
summarize haplotype divergence in unzipped regions

## align each haplotig to primary with nucmer
**batch_run_nucmer.sh** \
input: falcon_unzip reference (with samtools faidx file in same directory) \
output: calls run_nucmer4.sh (see below)

## cluster submission script
**run_nucmer4.sh** \
input: reference sequence ID, query sequence ID \
output: fasta, delta, and filtered delta files for each haplotig

## calculate divergence with show-coords
**run_show_coords.sh** \
input: run within directory containing filtered delta files, no user-input \
output: show-coords.out file



