# GSO

An Integrative OMICs Method to Predict Master Transcription Factors for Cell Fate Conversion

This study introduces a novel computational method predicting master transcription factors based on group sparse optimization, with which can be applicable to both single-cell and bulk OMICs data. When it is compared with other state-of-the-art prediction methods, it demonstrated superior performance. In short, this method facilitates fast identification of key regulators, increases the rate of successful conversion and reduces costs from experimental trials.

The GSO source code, input and related OMICs data can be downloaded.



# Usage for  GSO

## Input files needed to run GSO

1. A.txt  Matrix A: log2-transformed gene expression fold changes between control and TF perturbation samples  of regulators in  experiments for transcriptome datasets. Each column is the expression profile of each TF in experiments. Each row is the expression profile of each experiment of all regulators.

2. B.txt Matrix B: log2-transformed gene expression fold changes between control and TF perturbation samples of differentially expressed genes (DEGs) in experiments for transcriptome datasets. Each column is the expression profile of each target in experiments. Each row is the expression profile of each experiment of all DEGs.

3. InitialX.txt Initial matrix X describes the connections between TFs and targets, the TF-target connections defined by ChIP-seq/chip data were converted into an initial matrix. Each row is a target gene. Each column is a regulator. If TF i has binding site around the gene j promoter within 10 kbp, the Pearson correlation coefficient (PCC) between the expression profiles of TF i and gene j was calculated and assigned on Xi,j.

4. InitialX_SuperEnh.txt Initial matrix X describes the connections between TFs and targets, the TF-target connections defined by ChIP-seq/chip data were converted into an initial matrix. Each row is a target gene. Each column is a regulator. If TF i has binding site (BS) around the gene j promoter within 10 kbp, the Pearson correlation coefficient (PCC) between the expression profiles of TF i and gene j was calculated and assigned on Xi,j. Super-enhancer regions were used to filter the TFBSs. When a TFBS is outside super-enhancer regions, the Xi,j defined by this TFBS was reset as 0.

5. TFlistL.txt List of candidate regulators in transcriptome datasets (e.g. Transcription Factors). The order of the regulators are the same as those in Matrix A column name, initial matrix X column name and solution matrix X column name.
6. DEGlist.txt  DEGs in transcriptome datasets. The order of the DEGs are the same as those in Matrix `B` row name, initial matrix X row name and solution matrix X row name.

## Step to run GSO

### For MATLAB

#### GSO1 

1. Data preparation: 

   Code files (MaHardThr.m and GSO1.m) are in the folder Code. 

   Input files (`A.txt, B.txt, TFlist.txt, DEGlist.txt and InitialX_SuperEnh.txt`) are in the folder Input.

2. Run GSO1.m via MATLAB.

3. Then change the directory into folder `Output/GSO1`. Run the following command to score and rank the predicted TFs:

   sh ../../Code/TFScoring.sh Hard

#### GSO2 

1. Data preparation: 

   Code files (MaHardThr.m and GSO2.m) are in the folder Code. 

   Input files (`A.txt, B.txt, TFlist.txt, DEGlist.txt, InitialX`) are in the folder Input.

2. Run GSO2.m via MATLAB.

3. Then change the directory into folder `Output/GSO2`. Run the following command to score and rank the predicted TFs:

   sh ../../Code/TFScoring.sh Hard

#### gLASSO

1. Data preparation: 

   Code files (MaSoftThr.m and gLASSO.m) are in the folder Code. 

   Input files (`A.txt, B.txt, TFlist.txt, DEGlist.txt, InitialX`) are in the folder Input.

2. Run GSO2.m via MATLAB.

3. Then change the directory into folder `Output/GSO1`. Run the following command to score and rank the predicted TFs:

   sh ../../Code/TFScoring.sh Soft

### For R

1. Download the folder name code/R and install the R package

2. devtools::install_local('GSO-master/code/R/GSO_0.99.6.zip')

3. Once the R package is installed, please refer to the reference manual, e.g. inside R console type:

   library(GSO)

   ?demo_GSO
   
   ?TFScoring

# Acknowledgements

This work was supported by National Natural Science Foundation of China (41606143) awarded to JQ, research grants from Research Grants Council, Hong Kong (17121414M), startup funds from Mayo Clinic, USA (Mayo Clinic Arizona and Center for Individualized Medicine) to JW, National Natural Science Foundation of China (11871347), and Natural Science Foundation of Guangdong (2019A1515011917, 2020B1515310008) to YH, and National Science Council of Taiwan (MOST 102-2115-M-039-003-MY3) to JCY.
