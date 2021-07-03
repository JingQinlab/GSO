#' @title demo_GSO - The demo of GSO package
#' @description This is the main function to call algorithms: SoftThr, HalfThr and HardThr.
#' @param A Gene expression data of transcriptome factors (i.e. feature matrix in machine learning).
#' The dimension of A is nsample * ntf.
#' @param B Gene expression data of target genes (i.e. observation matrix in machine learning).
#' The dimension of B is nsample * ngene.
#' @param InitialX Gene expression data of Chromatin immunoprecipitation or other matrix
#' (i.e. initial iterative point in machine learning). The dimension of InitialX is ngene * ntf.
#' @param algorithm Three group sparse optimization algorithms: Soft, Half and Hard.
#' @param sparSequence Sequence of group sparsity level.
#' @param numCore Number of cores for computation.
#' @param maxIter Maximum iteration used in computation; default as 200.
#' @param path Output directory path.
#' @author Yaohua Hu <mayhhu@szu.edu.cn>
#'
#' Xinlin Hu <thompson-xinlin.hu@connect.polyu.hk>
#'
#' @details The demo_GSO function is used to solve group sparse optimization problem via different algorithm.
#' The SoftThr function aims to solve the problem:
#' \deqn{\min \|Ax-b\|^2 + \lambda \|x\|_{2,1}}
#' to obtain s-group sparse solution.
#'
#' The HalfThr function aims to solve the problem:
#' \deqn{\min \|Ax-b\|^2 + \lambda \|x\|_{2,\frac{1}{2}}}
#' to obtain s-group sparse solution.
#'
#' The HardThr function aims to solve the problem:
#' \deqn{\min \|Ax-b\|^2 + \lambda \|x\|_{2,0}}
#' to obtain s-group sparse solution.
#'
#' @references Y. Hu, C. Li, K. Meng, J. Qin and X. Yang*, Group sparse optimization via Lp,q regularization, Journal of Machine Learning Research, 18(30): 1-52, 2017.
#' @import stringr
#' @import foreach
#' @import parallel
#' @import doParallel
#' @import utils
#' @importFrom utils write.csv
#' @export demo_GSO
#' @examples
#' ntf <- 30
#' ngene <- 300
#' nsample <- 20
#' A <- matrix(rnorm(ntf*nsample), nrow = nsample, ncol = ntf)
#' B <- matrix(rnorm(ngene*nsample), nrow = nsample, ncol = ngene)
#' InitialX <- matrix(rnorm(ntf*ngene), nrow = ngene, ncol = ntf)
#' sparSeq <- c(1:10,seq(10,20,2))
#' algorithm <- 'Hard'
#' TFlist <- paste0('G',1:ntf)
#' resGSO <- demo_GSO(A, B, InitialX, algorithm, sparSeq)
demo_GSO <- function(A, B, InitialX, algorithm, sparSequence, numCore = 2, maxIter = 200, path = 'Output'){
  if(!dir.exists('Output')){ dir.create('Output') }
  NoA <- norm(A, '2')
  A <- A/NoA
  B <- B/NoA
  X1 <- t(InitialX)

  i <- NULL
  ImFunc <- function(i){
    s <- sparSequence[i]
    # Check directory & create
    if(!dir.exists(str_c(path, '/s', s))){ dir.create(str_c(path, '/s', s)) }
    if(algorithm == 'Soft'){
      X <- SoftThr(A, B, X1, maxIter, s)
    }else if(algorithm == 'Half'){
      X <- HalfThr(A, B, X1, maxIter, s)
    }else if(algorithm == 'Hard'){
      X <- HardThr(A, B, X1, maxIter, s)
    }
    X <- t(X)
    write.table(X, file = str_c(path, '/s', s, '/X', algorithm, '.txt'),col.names = F,row.names = F,quote = F,sep = '\t')
    return('Success.')
  }

  cl <- makeCluster(numCore)
  registerDoParallel(cl)

  res <- foreach(i = 1:length(sparSequence), .combine = 'rbind',
                 .export = str_c(algorithm, 'Thr'),
                 .packages = c('stringr')) %dopar% ImFunc(i)

  stopCluster(cl)
}
