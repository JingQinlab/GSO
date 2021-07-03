#' @title SoftThr - Iterative Soft Thresholding Algorithm
#' @description The function aims to solve \eqn{l_{2,1}} regularized least squares.
#' @param A Gene expression data of transcriptome factors (i.e. feature matrix in machine learning).
#' The dimension of A is n * t.
#' @param B Gene expression data of target genes (i.e. observation matrix in machine learning).
#' The dimension of B is m * t.
#' @param X1 Gene expression data of Chromatin immunoprecipitation or other matrix
#' (i.e. initial iterative point in machine learning). The dimension of InitialX is m * n.
#' @param maxIter Maximum iteration used in computation.
#' @param s Group sparsity level.
#' @author Yaohua Hu <mayhhu@szu.edu.cn>
#'
#' Xinlin Hu <thompson-xinlin.hu@connect.polyu.hk>
#'
#' @details The SoftThr function aims to solve the problem:
#' \deqn{\min \|Ax-b\|^2 + \lambda \|x\|_{2,1}}
#' to obtain s-group sparse solution.
#'
#' @references Y. Hu, C. Li, K. Meng, J. Qin and X. Yang*, Group sparse optimization via Lp,q regularization, Journal of Machine Learning Research, 18(30): 1-52, 2017.
#'
SoftThr <- function(A, B, X1, maxIter, s){
  n <- ncol(A)
  v <- 0.5
  X <- X1
  Bu1 <- 2 * v * t(A) %*% B
  Bu2 <- 2 * v * t(A) %*% A
  for(k in 1:maxIter){
    Bu <- X + Bu1 - Bu2 %*% X
    # The first step: gradient step
    BuR <- apply(Bu, 1, norm, '2')
    BuRO <- sort(BuR)
    criterion <- BuRO[n-s]
    lambda <- criterion/v

    ind <- which(BuR > criterion)
    X <- matrix(0, nrow = nrow(X), ncol = ncol(X))
    X[ind, ] <- (1 - v*lambda/BuR[ind]) * Bu[ind, ]

    print(str_c('The ', k, '-th iteration of the routine s=', s, ' completes.'))
  }
  return(X)
}
