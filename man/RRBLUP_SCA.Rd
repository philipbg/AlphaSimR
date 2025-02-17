% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/GS.R
\name{RRBLUP_SCA}
\alias{RRBLUP_SCA}
\title{RR-BLUP SCA Model}
\usage{
RRBLUP_SCA(
  pop,
  traits = 1,
  use = "pheno",
  snpChip = 1,
  useQtl = FALSE,
  maxIter = 40L,
  simParam = NULL,
  ...
)
}
\arguments{
\item{pop}{a \code{\link{Pop-class}} to serve as the training population}

\item{traits}{an integer indicating the trait to model, a trait name, or a
function of the traits returning a single value.}

\item{use}{train model using phenotypes "pheno", genetic values "gv", 
estimated breeding values "ebv", breeding values "bv", or randomly "rand"}

\item{snpChip}{an integer indicating which SNP chip genotype 
to use}

\item{useQtl}{should QTL genotypes be used instead of a SNP chip. 
If TRUE, snpChip specifies which trait's QTL to use, and thus these 
QTL may not match the QTL underlying the phenotype supplied in traits.}

\item{maxIter}{maximum number of iterations for convergence.}

\item{simParam}{an object of \code{\link{SimParam}}}

\item{...}{additional arguments if using a function for 
traits}
}
\description{
An extention of \code{\link{RRBLUP_GCA}} that adds dominance effects. 
Note that we have not seen any consistent benefit of this model over 
\code{\link{RRBLUP_GCA}}.
}
\examples{
#Create founder haplotypes
founderPop = quickHaplo(nInd=2, nChr=1, segSites=20)

#Set simulation parameters
SP = SimParam$new(founderPop)
SP$addTraitA(10)
SP$setVarE(h2=0.5)
SP$addSnpChip(10)

#Create population
pop = newPop(founderPop, simParam=SP)

#Run GS model and set EBV
ans = RRBLUP_SCA(pop, simParam=SP)
pop = setEBV(pop, ans, simParam=SP)

#Evaluate accuracy
cor(gv(pop), ebv(pop))

}
