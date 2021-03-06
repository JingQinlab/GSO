% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/HardThr.R
\name{HardThr}
\alias{HardThr}
\title{HardThr - Iterative Hard Thresholding Algorithm}
\usage{
HardThr(A, B, X1, maxIter, s)
}
\arguments{
\item{A}{Gene expression data of transcriptome factors (i.e. feature matrix in machine learning).
The dimension of A is n * t.}

\item{B}{Gene expression data of target genes (i.e. observation matrix in machine learning).
The dimension of B is m * t.}

\item{X1}{Gene expression data of Chromatin immunoprecipitation or other matrix
(i.e. initial iterative point in machine learning). The dimension of InitialX is m * n.}

\item{maxIter}{Maximum iteration used in computation.}

\item{s}{Group sparsity level}
}
\description{
The function aims to solve \eqn{l_{2,0}} regularized least squares.
}
\details{
The HardThr function aims to solve the problem:
\deqn{\min \|Ax-b\|^2 + \lambda \|x\|_{2,0}}
to obtain s-group sparse solution.
}
\references{
Y. Hu, C. Li, K. Meng, J. Qin and X. Yang*, Group sparse optimization via Lp,q regularization, Journal of Machine Learning Research, 18(30): 1-52, 2017.
}
\author{
Yaohua Hu \href{mailto:mayhhu@szu.edu.cn}{mayhhu@szu.edu.cn}

Xinlin Hu \href{mailto:thompson-xinlin.hu@connect.polyu.hk}{thompson-xinlin.hu@connect.polyu.hk}
}
