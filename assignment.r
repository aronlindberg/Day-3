# Load libraries, data, and sequence object
setwd("~/github/local/sequence_course/Day-3")
library(TraMineR)
data(biofam)
biofam.lab <- c("Parent", "Left", "Married", "Left/Married", "Child", "Left/Child", "Left/Married/Child", "Divorced")
biofam.shortlab <- c("P", "L", "M", "LM", "C", "LC", "LMC", "D")


# Create sequence plot sorted from the end for each class of the cohort variable created in assignment 2.

biofam$chort <- cut(biofam$birthyr,c(1900,1930,1940,1950,1959), labels=c("1900-1929", "1930-1939", "1940-1949", "1950-1959"), right=FALSE)

names(biofam) <- c(names(biofam)[1:dim(biofam)[2]-1], "cohort")

biofam.seq <- seqdef(biofam [, 10:25], states = biofam.shortlab, labels = biofam.lab, weights = biofam$wp00tbgs, xstep=8)

seqIplot(biofam.seq, group=biofam$cohort, sortv="from.end")

# Print the frequencies of the rst 20 sequences.
seqtab(biofam.seq, tlim=1:20)

# Create a sequence frequency plot of the 20 most frequent patterns grouped by values of the cohort variable and save it as a `jpeg' file.

pdf(file="output.pdf")
seqfplot(biofam.seq, group=biofam$cohort, tlim=1:20)
dev.off()
