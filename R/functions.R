#' @title webserver.start
#' @description This function publish the content of the current directory on a web server. Technically, 
#' it runs the system command "python -m SimpleHTTPServer 8000 &>/dev/null". The default port is 8000 and 
#' every output is redirected to /dev/null (i.e. not shown to the user). Both options can be changed by the user.
#' @param port Defaults to 8000
#' @param redirect.to.null Defaults to TRUE
#' @examples webserver.start()

webserver.start <- function(port="8000", redirect.to.null=TRUE){
  redirect=""
  if (redirect.to.null) redirect=" &>/dev/null"
  cmd <- paste("python -m SimpleHTTPServer ", port, redirect, " &", sep="")
  system(cmd)
}

#' @title webserver.stop
#' @description This function stops the web server started with ``webserver.start()''. The default port is 8000 and can be changed by the user to whatever port the server is running on.
#' @param port Defaults to 8000
#' @examples webserver.stop()

webserver.stop <- function(port="8000"){
  cmd <- paste("killall -e python -m SimpleHTTPServer ", port, sep="")
  system(cmd)
}
