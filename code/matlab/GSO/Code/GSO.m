%%% Copyright by Dr. Yaohua Hu College of Mathematics and Statistics, Shenzhen University.
%%% Email: mayhhu@szu.edu.cn

%%% GSO is a infer master TFs using GSO via L2,0 regularization model integrating transcriptomes and TF binding information. 

%% load data
cd ..
A = load('Input/A.txt'); NoA=norm(A); A=A/NoA; [m n]=size(A);
% Matrix A: expression profiles of TFs in multiple samples (for bulk transcriptomes) or cells (for single-cell transcriptomes). 
% It could be raw counts/RPKM/FPKM/TPM or log2-transformed gene expression fold changes between controls and treatments in TF perturbation experiments. 
% Each column is the expression profile of one TF in all samples/cells/experiments. Each row is the expression profile of all TFs in one sample/cell/experiment.
B = load('Input/B.txt'); B=B/NoA; [m t]=size(B);
% Matrix B: expression profiles of differentially expressed genes (DEGs) in multiple samples (for bulk transcriptomes) or cells (for single-cell transcriptomes). 
% It could be raw counts/RPKM/FPKM/TPM or log2-transformed gene expression fold changes between controls and TF perturbation experiments.
% Each column is the expression profile of DEG in all samples/cells/experiments. Each row is the expression profile of all DEGs in one sample/cell/experiment.
InitialX = load('Input/InitialX.txt'); X1=InitialX';
% Initial matrix X describes the connections between TFs and DEGs, the TF-DEG connections defined by ChIP-seq/chip data were converted into an initial matrix. 
% Each row is the transcriptome profile between DEG with all TFs. Each column is the transcriptome profile between TF with all DEGs. 
% If TF i has binding site (BS) around the DEG j promoter within 10 kbp, the Pearson correlation coefficient (PCC) between the expression profiles of TF i and DEG j was calculated and assigned on Xi,j.
MAX_ITERS = 500; myformat = '%5d ';
 % set the stopping number of iterations.
Ssequence=[1:10 12:2:20]; SQI=size(Ssequence); 
% the sequence of group sparsity levels setted in our code.
si=1; mkdir('GSO');

%% run MaHardThr (IHTA) for solving GSO
while si<=SQI(2);
    s=Ssequence(si);
    %s denotes the current group sparsity level (number of master TFs to be searched).
    
    cd Code/; X = MaHardThr(A,B,X1,MAX_ITERS,s);
    % the IHTA for GSO starting from the initial X1    
    
    cd ..
    XHard=X'; save ('XHard.txt', 'XHard', '-ascii');
    newdir = sprintf('s%d',s); mkdir(newdir); 
    movefile('XHard.txt',newdir); movefile(newdir,'GSO');
    
    fprintf('The routine of sparsity level s=%d  completes.\r\n',s)
    si=si+1;
end
newdir = sprintf('GSO'); mkdir('Output'); movefile(newdir,'Output');