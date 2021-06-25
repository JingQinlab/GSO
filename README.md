# GSO
An Integrative OMICs Method to Predict Master Transcription Factors for Cell Fate Conversion
Cell fate conversion by overexpressing defined factors is a powerful tool in regenerative medicine. However, identifying key factors for cell fate conversion requires laborious experimental efforts, thus many of such conversions have not been achieved yet. Nevertheless, cell fate conversions found in many published studies were incomplete as the expression of important gene sets could not be manipulated thoroughly. Therefore, the identification of master transcription factors for complete and efficient conversion is crucial to render this technology more clinical applicational. In the past decade, systematic analyses on various single-cell and bulk OMICs data have uncovered numerous gene regulatory mechanisms, and made it possible to predict master gene regulators during cell fate conversion. This study introduces a novel computational method predicting master transcription factors based on group sparse optimization, with which can be applicable to both single-cell and bulk OMICs data. When it is compared with other state-of-the-art prediction methods, it demonstrated superior performance. In short, this method facilitates fast identification of key regulators, increases the rate of successful conversion and reduces costs from experimental trials.

The GSO source code, input and related OMICs data can be downloaded by clicking the hyperlinks on the left sidebar.

# Usage
Infer master TFs using group sparse optimization (GSO) integrating transcriptomes, TF binding and super-enhancer information: Code files (MaHardThr.m and GSO1.m) are in the folder Code. 
Input files (A.txt, B.txt and InitialX_SuperEnh.txt) are in the folder Input. 
Run GSO1.m via MATLAB. Then change the directory into folder Output/GSO1.
Run the following command to score and rank the predicted TFs:
sh ../../Code/TFScoring.sh Hard

Infer master TFs using GSO integrating transcriptomes and TF binding information: Code files (MaHardThr.m and GSO2.m) are in the folder Code. 
Input files (A.txt, B.txt and InitialX.txt) are in the folder Input.
Run GSO2.m via MATLAB. Then change the directory into folder Output/GSO2. 
Run the following command to score and rank the predicted TFs:
sh ../../Code/TFScoring.sh Hard

# Acknowledgements
This work was supported by National Natural Science Foundation of China (41606143) awarded to JQ, research grants from Research Grants Council, Hong Kong (17121414M), startup funds from Mayo Clinic, USA (Mayo Clinic Arizona and Center for Individualized Medicine) to JW, National Natural Science Foundation of China (11871347), and Natural Science Foundation of Guangdong (2019A1515011917, 2020B1515310008) to YH, and National Science Council of Taiwan (MOST 102-2115-M-039-003-MY3) to JCY.
