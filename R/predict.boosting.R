#' Predict method for boosting objects
#'
#' Predicted values based on boosting object.
#'
#' @param object A boosting object estimated using the ic.glmnet function.
#' @param newdata An optional data to look for the explanatory variables used to predict. If omitted, the fitted values are used.
#' @param ... Arguments to be passed to other methods.
#' @export
#' @examples
#' ## == This example uses the Brazilian inflation data from
#' #Garcia, Medeiros and Vasconcelos (2017) == ##
#' data("BRinf")
#'
#' ## == Data preparation == ##
#' ## == The model is yt = a + Xt-1'b + ut == ##
#' aux = embed(BRinf,2)
#' y=aux[,1]
#' x=aux[,-c(1:ncol(BRinf))]
#'
#' ## == break data (in-sample and out-of-sample)
#' yin=y[1:120]
#' yout=y[-c(1:120)]
#' xin=x[1:120,]
#' xout=x[-c(1:120),]
#'
#' ## == Use factors == ##
#' factors=prcomp(xin,scale. = TRUE)
#' xfact=factors$x[,1:10]
#'
#' model=boosting(xfact,yin)
#'
#' xfactout=predict(factors,xout)[,1:10]
#' pred=predict(model,xfactout)
#'
#' plot(yout,type="l")
#' lines(pred,col=2)

predict.boosting=function(object,newdata=NULL,...){
  if(is.null(newdata)){
    return(fitted(object))
  }

  parameters = coef(object)
  ybar = mean(object$y)
  final.prediction = ybar + newdata %*% parameters
  return(final.prediction)
}

