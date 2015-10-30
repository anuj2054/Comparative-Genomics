pMT

David Ochoa
(ochoa@ebi.ac.uk)

-------------------- 
 
This directory contains an academic version of pMT as well as the E coli dataset 
described in Ochoa et al. (2015). This program requires the free R software for 
statistical computing to be installed (http://www.r-project.org/).

The methodology for predicting protein interactions implemented in this program 
requires a genome-wide collection of phylogenetic trees (distance files actually)
to be applied. Such set is used for generating the background distributions of 
correlation values which are the basis for extracting p-values. Take a look at 
Ochoa et al. (1015) below for details. This program also requires some expertise
in Bioinformatics and computing in general. If you do not have that large set of
trees/distance files or you lack the required expertise, please consider using 
other alternatives, including web-based solutions (take a look at: 
http://csbg.cnb.csic.es/mirrortree/)

---------------------

The generic command line for running the system is:

Rscript pvalMatrix.R <taxidsFile> <distancesDir> <groups> <probability> <iterations> <Results>

where:

<taxidsFile>: File with the list of IDs of the organisms that are going to be used. These 
IDs should be the same as in the distances files (see below). The normal way of running 
pMT is to include all organisms within our dataset in this file. But in certain 
circumstances we might want to run it with a given subset of organisms only (as in the 
historic datasets of organisms used in Ochoa et al. (2015).
 
<distancesDir>: Directory with inter-organisms distances for all proteins. One file for 
each protein, with extension ".dist". The format of these files is:
org1<TAB>org2<TAB>distance
org1<TAB>org3<TAB>distance
........
....
The organism IDs within these files ("org1", "org2", ...) should be the same as in 
<taxidsFile>

<groups>: Number of bins for the distribution of organisms in common. The tree 
shuffling procedure will be carried out for each group independently. See Ochoa et al. 
(2015) for details.
 
<probability>: Probability of swapping a given branch of a tree with another 
(interchanging their corresponding rows and columns in the distance matrix). See 
Ochoa et al. (2015) for details.

<iterations>: Number of iterations of the tree-swapping procedure. See Ochoa et al. 
(2015) for details.

<Results>: File where the results will be stored. The file will be created/overwritten. 
The format is:
prot1<TAB>prot2<TAB>n<TAB>r<TAB>p-value
prot1<TAB>prot3<TAB>n<TAB>r<TAB>p-value
......
....
"prot1", "prot2", ... are the IDs of the proteins. These are taken from the filenames of the 
distance files (see above) removing the ".dist" extension. 
"n" is the number of organisms in common between the two proteins.
"r" is the original mirrortree score (correlation between the distance matrices of both 
proteins). Its associated "p-value" (main score of pMT) is shown in the last column.  
See Ochoa et al. (2015) for details.

For running the E coli example described in Ochoa et al. (2015), with the parameters 
used in that paper, download the 3 files within this web site, and uncompress/unpack the 
directory with the distance files (to "distances/"):

    gunzip distances.tar.gz; tar xvf distances.tar

Then run pMT with the following command line (for 40 intervals of number of 
organisms in common, 5% probability of swapping a branch and 1000 permutations)

    Rscript mt_pvals.R  alltaxids.txt  distances/  40  0.05  1000 ./RESULTS.csv

Note that this can take a really long time to run depending on the computer resources.

For obtaining the ProfileCorrelation and ContextMirror programs also used in that paper 
take a look at Juan et al (2008).

Contact David Ochoa (ochoa@ebi.ac.uk) for any technical issue related to this software.

-----------------------

* David Juan, Florencio Pazos & Alfonso Valencia. (2008). High-confidence prediction 
of global interactomes based on genome-wide coevolutionary networks. Proc Natl Acad 
Sci USA. 105(3):934-939.

* David Ochoa, David Juan, Alfonso Valencia & Florencio Pazos (2015) Detection of 
significant protein co-evolution. Bioinformatics. doi: 10.1093/bioinformatics/btv102 
(advance access). 

