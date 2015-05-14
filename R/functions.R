#' @title Go2Web
#' @description This function publish the content of the current directory on a web server. Technically, 
#' it runs the system command "python -m SimpleHTTPServer 8000 &>/dev/null". The default port is 8000 and 
#' every output is redirected to /dev/null (i.e. not shown to the user). Both options can be changed by the user.
#' @param port Defaults to 8000
#' @param redirect.to.null Defaults to TRUE
#' @examples Go2Web()

Go2Web <- function(port="8000", redirect.to.null=TRUE){
  redirect=""
  if (redirect.to.null) redirect=" &>/dev/null"
  cmd <- paste("python -m SimpleHTTPServer ", port, redirect, " &", sep="")
  system(cmd)
}
