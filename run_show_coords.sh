# make file of file names for filtered delta files in CWD
# exlude empty delta files (haplotig has no alignment to primary)
find . -name "*.g.delta" -size +0 | sort > delta.fofn
for d in `cat delta.fofn`
do
        show-coords -rTHlc -L 2000 $d >> show-coords.out
done
