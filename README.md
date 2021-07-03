# GSO

Cell Fate Conversion Prediction by Group Sparse Optimization Method Utilizing Single-Cell and Bulk OMICs Data

Cell fate conversion by overexpressing defined factors is a powerful tool in regenerative medicine. However, identifying key factors for cell fate conversion requires laborious experimental efforts, thus many of such conversions have not been achieved yet. Nevertheless, cell fate conversions found in many published studies were incomplete as the expression of important gene sets could not be manipulated thoroughly. Therefore, the identification of master transcription factors (TFs) for complete and efficient conversion is crucial to render this technology more applicable clinically. In the past decade, systematic analyses on various single-cell and bulk OMICs data have uncovered numerous gene regulatory mechanisms, and made it possible to predict master gene regulators during cell fate conversion. 

By virtue of the sparse structure of master TFs and the group structure of their simultaneous regulatory effects on the cell fate conversion process, this study introduces a novel computational method predicting master TFs based on group sparse optimization technique integrating data from multi-OMICs levels, which can be applicable to both single-cell and bulk OMICs data with a high tolerance of data sparsity. This method facilitates fast identification of key regulators, give raise to the possibility of higher successful conversion rate and in the hope of reducing experimental cost.

The GSO source code, data, test data can be downloaded.

# Usage for  GSO

## Input files needed to run GSO

1. A.txt Matrix A: expression profiles of TFs in multiple samples (for bulk transcriptomes) or cells (for single-cell transcriptomes). It could be raw counts/RPKM/FPKM/TPM or log2-transformed gene expression fold changes between controls and treatments in TF perturbation experiments. Each column is the expression profile of one TF in all samples/cells/experiments. Each row is the expression profile of all TFs in one sample/cell/experiment.
2. B.txt Matrix B: expression profiles of differentially expressed genes (DEGs) in multiple samples (for bulk transcriptomes) or cells (for single-cell transcriptomes). It could be raw counts/RPKM/FPKM/TPM or log2-transformed gene expression fold changes between controls and TF perturbation experiments. Each column is the expression profile of DEG in all samples/cells/experiments. Each row is the expression profile of all DEGs in one sample/cell/experiment.
3. InitialX.txt Initial matrix X describes the connections between TFs and DEGs, the TF-DEG connections defined by ChIP-seq/chip data were converted into an initial matrix. Each row is the transcriptome profile between DEG with all TFs. Each column is the transcriptome profile between TF with all DEGs. If TF i has binding site (BS) around the DEG j promoter within 10 kbp, the Pearson correlation coefficient (PCC) between the expression profiles of TF i and DEG j was calculated and assigned on Xi,j.
4. InitialX_SuperEnh.txt Initial matrix X describes the connections between TFs and DEGs, the TF-DEG connections defined by ChIP-seq/chip data were converted into an initial matrix. Each row is the transcriptome profile between DEG with all TFs. Each column is the transcriptome profile between TF with all DEGs. If TF i has binding site (BS) around the DEG j promoter within 10 kbp, the Pearson correlation coefficient (PCC) between the expression profiles of TF i and DEG j was calculated and assigned on Xi,j. Super-enhancer regions were used to filter the TFBSs. When a TFBS is outside super-enhancer regions, the Xi,j defined by this TFBS was reset as 0.
5. TFlistL.txt List of TFs in transcriptome datasets. The order of the TFs are the same as the column name in Matrix A, initial X and solution matrix.
6. DEGlist.txt List of DEGs in transcriptome datasets. The order of the DEGs are the same as the row name in Matrix B, initial X and solution matrix.

## Step to run GSO

### For MATLAB

#### GSO1 

1. Before GSO1: 

   i. Prepare the code files (`MaHardThr.m` and `GSO1.m`) in the folder `Code`. 

   ii. Prepare the dataset (`A.txt`, `B.txt`, `TFlist.txt`, `DEGlist.txt` and `InitialX_SuperEnh.txt`) in the folder `Input`.

2. Run GSO1.m in MATLAB.

3. Evaluation

   i. Change the directory into folder `Output/GSO1`. 

   ii. Run the following command to score and rank the predicted TFs:

   ​       `sh ../../Code/TFScoring.sh Hard`

#### GSO2 

1. Before GSO2: 

   i. Prepare the code files (`MaHardThr.m` and `GSO2.m`) in the folder `Code`. 

   ii. Prepare the dataset (`A.txt`, `B.txt`, `TFlist.txt`, `DEGlist.txt` and `InitialX_SuperEnh.txt`) in the folder `Input`.

2. Run GSO2.m in MATLAB.

3. Evaluation

   i. Change the directory into folder `Output/GSO2`. 

   ii. Run the following command to score and rank the predicted TFs:

   ​       `sh ../../Code/TFScoring.sh Hard`

#### gLASSO

1. Before gLASSO:

   i. Prepare the code files (`MaHardThr.m` and `gLASSO.m`) in the folder `Code`. 

   ii. Prepare the dataset (`A.txt`, `B.txt`, `TFlist.txt`, `DEGlist.txt` and `InitialX_SuperEnh.txt`) in the folder `Input`.

2. Run gLASSO.m in MATLAB.

3. Evaluation

   i. Change the directory into folder `Output/gLASSO`. 

   ii. Run the following command to score and rank the predicted TFs:

   ​       `sh ../../Code/TFScoring.sh Hard`

### For R

1. Download the folder name code/R and install the R package

   `install.package('devtools')`

   `devtools::install_github('JingQinlab/GSO/code/R')`

2. Once the R package is installed, please refer to the reference manual, e.g. inside R console type:

   `library(GSO)`

   `?demo_GSO`

   `?TFScoring`

## Output

To score and rank the master TFs reported by GSO and group LASSO (gLASSO), we selected a series of group sparsity level K (i.e., the number of TF predicted as master TFs) from 1 to 20, and ran one GSO (or gLASSO) for each K. For each TF, we used Kmin to denote the smallest value of K when this TF is selected as master TF. We assumed that TFs selected by GSO are more important when K is smaller, so a TF got a higher score if its Kmin was smaller. 

### For MATLAB

1. The calculated results are in the Output folder.
2. Folders GSO1, GSO2 and gLASSO are outputs from GSO1.m, GSO2.m, and gLASSO.m, respectively.
3. In each output folder, folders s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s12, s14, s16, s18, s20 contain solution *X* of each *K* from 1 to 20. In each s*K* folder, XHard.txt or XSoft.txt are the solution matrix *X* derived from iterative hard thresholding algorithm or iterative soft thresholding algorithm, respectively.
4. Hard_TFranking.txt or Soft_TFranking.txt  TF ranking after considering all *K*s. 

### For R

1. The calculated results are in the Output folder.
2. In  Output folder, folders s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s12, s14, s16, s18, s20 contain solution *X* of each *K* from 1 to 20. In each s*K* folder, XHard.txt or XSoft.txt are the solution matrix *X* derived from iterative hard thresholding algorithm or iterative soft thresholding algorithm, respectively.
3. Hard_TFranking.txt or Soft_TFranking.txt  TF ranking after considering all *K*s. 



# Acknowledgements

This work was supported by National Natural Science Foundation of China (41606143) awarded to JQ, research grants from Research Grants Council, Hong Kong (17121414M), startup funds from Mayo Clinic, USA (Mayo Clinic Arizona and Center for Individualized Medicine) to JW, National Natural Science Foundation of China (11871347), and Natural Science Foundation of Guangdong (2019A1515011917, 2020B1515310008) to YH, and National Science Council of Taiwan (MOST 102-2115-M-039-003-MY3) to JCY.

# Contact

**Dr. Junwen Wang**, Department of Health Sciences Research and Center for Individualized Medicine, Mayo Clinic.

Email: Wang.Junwen@mayo.edu. 

**Dr. Jing Qin**, School of Life Sciences, The Chinese University of Hong Kong 

Email: qinjing@cuhk.edu.hk

**Dr. Yaohua Hu**, College of Mathematics and Statistics, Shenzhen University.

Email: mayhhu@szu.edu.cn
