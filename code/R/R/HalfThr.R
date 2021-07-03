#' @title HalfThr - Iterative Half Thresholding Algorithm
#' @description The function aims to solve \eqn{l_{2,\frac{1}{2}}} regularized least squares.
#' @param A Gene expression data of transcriptome factors (i.e. feature matrix in machine learning).
#' The dimension of A is n * t.
#' @param B Gene expression data of target genes (i.e. observation matrix in machine learning).
#' The dimension of B is m * t.
#' @param X1 Gene expression data of Chromatin immunoprecipitation or other matrix
#' (i.e. initial iterative point in machine learning). The dimension of InitialX is m * n.
#' @param maxIter Maximum iteration used in computation.
#' @param s Group sparsity level
#' @author Yaohua Hu <mayhhu@szu.edu.cn>
#'
#' Xinlin Hu <thompson-xinlin.hu@connect.polyu.hk>
#'
#' @details The HalfThr function aims to solve the problem:
#' \deqn{\min \|Ax-b\|^2 + \lambda \|x\|_{2,\frac{1}{2}}}
#' to obtain s-group sparse solution.
#'
#' @references Y. Hu, C. Li, K. Meng, J. Qin and X. Yang*, Group sparse optimization via Lp,q regularization, Journal of Machine Learning Research, 18(30): 1-52, 2017.
#'
HalfThr <- function(A, B, X1, maxIter, s){
  n <- ncol(A)
  v <- 0.5
  va1 <- (2/3)^(1.5)/v
  X <- X1
  Bu1 <- 2 * v * t(A) %*% B
  Bu2 <- 2 * v * t(A) %*% A
  for(k in 1:maxIter){
    Bu <- X + Bu1 - Bu2 %*% X
    # The first step: gradient step
    BuR <- apply(Bu, 1, norm, '2')
    BuRO <- sort(BuR)
    BuV <- BuRO[n-s]^(1.5)
    lambda <- va1 * BuV
    criterion <- BuRO[n-s]
    q <- lambda * v / 4

    ind <- which(BuR > criterion)
    phi <- rep(0, length(BuR))
    eta <- rep(0, length(BuR))
    phi[ind] <- acos(q * (3/BuR[ind])^(1.5))
    eta[ind] <- 16 * BuR[ind]^(1.5) * cos((pi-phi[ind])/3)^3
    X <- matrix(0, nrow = nrow(X), ncol = ncol(X))
    X[ind, ] <- eta[ind]/(3 * sqrt(3) * lambda * v + eta[ind]) * Bu[ind, ]

    print(str_c('The ', k, '-th iteration of the routine s=', s, ' completes.'))
  }
  return(X)
}
