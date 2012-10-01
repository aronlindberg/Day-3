# Load libraries, data, and sequence object
setwd("~/github/local/sequence_course/Day-3")
library(TraMineR)
data(biofam)
biofam.lab <- c("Parent", "Left", "Married", "Left/Married", "Child", "Left/Child", "Left/Married/Child", "Divorced")
bf.shortlab <- c("P", "L", "M", "LM", "C", "LC", "LMC", "D")

# Create sequence plot sorted from the end for each class of the cohort variable created in assignment 2.

biofam$chort <- cut(biofam$birthyr,c(1900,1930,1940,1950,1959), labels=c("1900-1929", "1930-1939", "1940-1949", "1950-1959"), right=FALSE)

names(biofam) <- c(names(biofam)[1:dim(biofam)[2]-1], "cohort")

biofam.seq <- seqdef(biofam [, 10:25], states = bf.shortlab, labels = biofam.lab, weights = biofam$wp00tbgs, xstep=8)

seqIplot(biofam.seq, group=biofam$cohort, sortv="from.end")

# Print the frequencies of the rst 20 sequences.
seqtab(biofam.seq, tlim=1:20)

# Create a sequence frequency plot of the 20 most frequent patterns grouped by values of the cohort variable and save it as a `jpeg' file.

pdf(file="output.pdf")
seqfplot(biofam.seq, group=biofam$cohort, tlim=1:20)
dev.off()

# Compute the matrix of transition rates
bf.trate <- seqtrate(biofam.seq)

# Display only first two digits of the rates
round(bf.trate, digits=3)

# Transition rate from LM to LMC
bf.trate[which(bf.shortlab=="LM"),which(bf.shortlab=="LMC")]

# or using row and column labels of the transition matrix
bf.trate["[LM ->]","[-> LMC]"]

# Plot of successive transversal distributions
seqdplot(biofam.seq, group=biofam$cohort)

# At which age reaches the entropy its maximum?
# 1. First extract the object of transversal statistics
bf.seqstatd <-seqstatd(biofam.seq)

# 2. Extract vector of transversal entropies
bf.t.entrop <- bf.seqstatd$Entropy

# 3. Age at maximum is given ba the name at the position where maximum is reached.
names(biofam.seq)[which(bf.t.entrop==max(bf.t.entrop))]

## 4. Mean time plot and modal state plot in a same graphical area
## Here we use par(mfrow= ...)
## Automatic legend must be suppressed because not compatible with par(mfrow=...)
par(mfrow = c(2, 2))
seqmtplot(biofam.seq, withlegend = FALSE)
seqmtplot(biofam.seq, withlegend = FALSE, cex.plot = .7)
seqlegend(biofam.seq, fontsize = 1.2)
