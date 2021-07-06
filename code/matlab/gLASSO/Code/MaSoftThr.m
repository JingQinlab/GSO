%%% Copyright by Dr. Yaohua Hu College of Mathematics and Statistics, Shenzhen University.
%%% Email: mayhhu@szu.edu.cn

%%% MaSoftThr is the iterative soft threholding algorithm for solving group Lasso. 
%%% For details, one can refer to Hu, Y., Li, C., Meng, K., Qin, J. and Yang, X. (2015) Group sparse optimization via ℓp,q regularization. http://arxiv.org/pdf/1601.07779.pdf.

function X = MaSoftThr(A,B,X1,MAX_ITERS,s)

X=X1; v=0.5; [m n]=size(A); [m t]=size(B);
Bu1=2*v*A'*B; Bu2=2*v*A'*A; BuR=zeros(n,1);

for k=1:MAX_ITERS 
    tic
      Bu=X+Bu1-Bu2*X;
      %the first step: gradient step.
      for j=1:n;
          BuR(j)=norm(Bu(j,:));
      end
      BuRO=sort(BuR); criterion=BuRO(n-s); lambda=criterion/v;      
      for j=1:n;
          Y1=norm(Bu(j,:));
         if Y1>criterion
             X(j,:)=(1-v*lambda/Y1).*Bu(j,:);
             %the second step: soft thresholding operator.
         else
             X(j,:)=zeros(1,t);
         end
      end
      
      fprintf('The %d -th iteration of the routine s=%d  completes.\r\n',k,s)
      toc
end