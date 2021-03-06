% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/meanSamplingDistribution.R
\name{randomSample}
\alias{randomSample}
\title{Generate an arbitrary number of random samples from a normal distribution}
\usage{
randomSample(mu = 0, sigma = 1, sampleSize = 25, numSamples = 1)
}
\arguments{
\item{mu}{mean of normal distribution}

\item{sigma}{standard deviation of normal distribution}

\item{sampleSize}{size of each sample}

\item{numSamples}{number of random samples to be generated}
}
\value{
A data frame whose columns are random samples from a normal distribution
}
\description{
Returns a data frame whose columns are random samples from a normal distribution
}
\examples{
head(randomSample(mu=1,sigma=4,sampleSize=100,numSamples=5))

}
\author{
Joe Zemmels
}
