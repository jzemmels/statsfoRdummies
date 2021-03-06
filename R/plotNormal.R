#' @name plotNormal
#' @export
#' @author Joe Zemmels
#'
#' @title Plot a normal distribution
#'
#' @description Returns a ggplot or plotly object of a normal distribution with a specified significance level
#'
#' @param mu mean of normal distribution
#' @param sigma standard deviation of normal distribution
#' @param alpha significance level
#' @param obs observed z-statistic (randomly generated if left blank)
#' @param direction direction of alternative hypothesis
#' @param plotly specifies whether a plotly object is desired
#'
#' @return A ggplot or plotly object, depending on whether the plotly argument was specified TRUE or FALSE.
#'
#' @examples
#' plotNormal() #default standard normal ggplot
#' plotNormal(mu=5,sigma=2,alpha=.1,obs=.5,plotly=TRUE) #customized plotly
#'
#' @importFrom plotly ggplotly
#' @importFrom stats dnorm qnorm rnorm
#' @import ggplot2

plotNormal <- function(mu=0,sigma=1,alpha=.05,obs=NULL,direction=intToUtf8("8800"),plotly=FALSE){
  assertNumeric(c(mu,sigma,alpha),any.missing = FALSE,finite = TRUE)
  assertNumber(obs,null.ok = TRUE,finite=TRUE)
  assertChoice(direction,choices = c("<",">",intToUtf8("8800")))
  assertLogical(plotly)

  if(is.null(obs)){
    obs <- rnorm(n=1,mean=mu,sd=sigma)
  }

  x <- seq(mu - 3*sigma,mu + 3*sigma,by = sigma/100)

  plt <- ggplot(as.data.frame(x), aes(x)) +
    geom_line(aes(x = x,y = dnorm(x,mean = mu,sd = sigma))) +
    # stat_function(fun = dnorm,args=list(mean=mu,sd=sigma)) +
    theme_bw()

  if(direction == intToUtf8("8800")){ #two-sided. intToUtf8("8800") is not-equal-to
    plt <- plt +
      stat_function(fun = dnorm,args=list(mean=mu,sd=sigma),
                    xlim = c(qnorm(mean = mu,sd=sigma,p = 1-alpha/2),max(x)),
                    geom = "area",
                    fill="lightblue") +
      stat_function(fun = dnorm,args=list(mean=mu,sd=sigma),
                    xlim = c(min(x),qnorm(mean = mu,sd=sigma,p = alpha/2)),
                    geom = "area",
                    fill="lightblue")
  }
  if(direction == ">"){
    plt <- plt +
      stat_function(fun = dnorm,args=list(mean=mu,sd=sigma),
                    xlim = c(qnorm(mean = mu,sd=sigma,p = 1-alpha),max(x)),
                    geom = "area",
                    fill="lightblue")
  }
  if(direction == "<"){
    plt <- plt +
      stat_function(fun = dnorm,args=list(mean=mu,sd=sigma),
                    xlim = c(min(x),qnorm(mean = mu,sd=sigma,p = alpha)),
                    geom = "area",
                    fill="lightblue")
  }

  plt <- plt +
    geom_vline(xintercept = obs,colour="black",linetype="dashed",size=2) #add observation to plot as top layer

  if(plotly){ #turns ggplot into plotly object
    plt <- ggplotly(plt)
  }

  return(plt)
}
