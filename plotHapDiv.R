# read in show coords file
mySpecies<-read.table("path/to/dir/show-coords.out", header=F)
header=c("ref_start","ref_end","qry_start","qry_end","ref_alnL","qry_alnL","PID","ref_length","qry_length","ref_cov","qry_cov","refID","qryID")
colnames(mySpecies)<-header

# get sum of aln lengths in order to do quality filtering of alignments
tmp<-aggregate(mySpecies$qry_alnL, by=list(Category=mySpecies$qryID), FUN=sum)
alnSummary_mySpecies<-tmp
colnames(alnSummary_mySpecies)<-c("qryID","cummAlnL")

# assign sum to qry ID and qry length
alnSummary_mySpecies<-cbind(alnSummary_mySpecies,unique(mySpecies[,c(13,9)])[,2])
colnames(alnSummary_mySpecies)<-c("qryID","cummAlnL","qry_length")

# add aln proportion
tmp1<-cbind(alnSummary_mySpecies,alnSummary_mySpecies$cummAlnL/alnSummary_mySpecies$qry_length)
colnames(tmp1)<-c("qryID","cummAlnL","qry_length","alnProp")
alnSummary_mySpecies<-tmp1

# qry IDs with "good" aln (alignment length is 80-110% length of haplotig
filt_qryID<-alnSummary_mySpecies$qryID[which(alnSummary_mySpecies$alnProp>0.80 & alnSummary_mySpecies$alnProp<1.10)]
filt_mySpecies<-mySpecies[mySpecies$qryID %in% filt_qryID,]

# convert PID to PercDiv
PercDiv<-100-mySpecies$PID
mySpecies<-cbind(mySpecies,PercDiv)
PercDiv<-100-filt_mySpecies$PID
filt_mySpecies<-cbind(filt_mySpecies,PercDiv)

# plot to compare filtered vs unfiltered
boxplot(mySpecies$PercDiv, filt_mySpecies$PercDiv)
