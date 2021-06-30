%%% Copyright by Dr. Yaohua Hu College of Mathematics and Statistics, Shenzhen University.
%%% Email: mayhhu@szu.edu.cn

%%% gLASSO is a infer master TFs using group LASSO (least absolute shrinkage and selection operator) integrating transcriptomes and TF binding information. 

%% load data
cd ..
A = load('input/A.txt'); NoA=norm(A); A=A/NoA; [m n]=size(A);
% Matrix A: log2-transformed gene expression fold changes between control and TF perturbation samples of 939 regulators in 245 experiments. 
% Candidate regulators, including TFs, mediators, co-factors, chromatin modifiers and repressors, were collected from four TF databases, 
% TRANSFAC, JASPAR, UniPROBE and TFCat, as well as literatures. 
B = load('input/B.txt'); B=B/NoA; [m t]=size(B);
% Matrix B: log2-transformed gene expression fold changes between control and TF perturbation samples of 4000 differentially expressed genes (DEGs)in 245 experiments.
% DEGs are defined by comparing transcriptomes ofmouse embryonic fibroblast (MEF) and mouse embryonic stem cells (mESCs).
InitialX = load('input/InitialX.txt'); X1=InitialX';
% InitialX  describes the connections between TFs and targets, the TF-target connections defined by ChIP-seq/chip data were converted into an initial matrix. 
MAX_ITERS = 500; myformat = '%5d ';
 % set the stopping number of iterations.
Ssequence=[1:10 12:2:20]; SQI=size(Ssequence); 
% the sequence of group sparsity levels setted in our code.
si=1; mkdir('gLASSO');

%% run MaSoftThr (ISTA) for solving gLASSO
while si<=SQI(2);
    s=Ssequence(si);
    %s denotes the current group sparsity level (number of master TFs to be searched).
    
    cd Code\; X = MaSoftThr(A,B,X1,MAX_ITERS,s);
    % the ISTA for gLASSO starting from the initial X1    
    
    cd ..
    XSoft=X'; save ('XSoft.txt', 'XSoft', '-ascii');
    newdir = sprintf('s%d',s); mkdir(newdir); 
    movefile('XSoft.txt',newdir); movefile(newdir,'gLASSO');
    
    fprintf('The routine of sparsity level s=%d  completes.\r\n',s)
    si=si+1;
end
newdir = sprintf('gLASSO'); mkdir('Output'); movefile(newdir,'Output');