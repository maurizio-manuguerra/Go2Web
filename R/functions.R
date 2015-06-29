#' @title webserver.start
#' @description This function publish the content of the current directory on a web server. Technically, 
#' it runs the system command "python -m SimpleHTTPServer 8004 &>/dev/null" or its ruby counterpart. The default port is 8004 and 
#' every output is redirected to /dev/null (i.e. not shown to the user). Both options can be changed by the user.
#' @param port Defaults to 8004
#' @param redirect.to.null Defaults to TRUE
#' @examples webserver.start()

webserver.start <- function(port=8004, redirect.to.null=TRUE, lang=c('ruby', 'python')){
  redirect=""
  if (redirect.to.null) redirect=" &>/dev/null"
  if (lang=='python'){
    cmd <- paste("python -m SimpleHTTPServer ", as.character(port), redirect, " &", sep="")
  } else if (lang=='ruby'){
    cmd <- paste("ruby -run -ehttpd . -p ", as.character(port), redirect, " &", sep="")
  }
  system(cmd)
  .Last <<- eval(parse(text=paste("function() webserver.stop(port=",as.character(port),")")))
}



#' @title webserver.stop
#' @description This function stops the web server started with ``webserver.start()''. The default port is 8004 and can be changed by the user to whatever port the server is running on.
#' @param port Defaults to 8004
#' @examples webserver.stop()

webserver.stop <- function(port=8004, lang=c('ruby', 'python')){
  if (lang=='python'){
    cmd <- paste("killall -e python -m SimpleHTTPServer ", as.character(port), sep="")
  } else if (lang=='ruby'){
    cmd <- "killall -e ruby"
  }

  system(cmd)
  rm(.Last, envir=.GlobalEnv)
}

#' @title webserver.status
#' @description This function checks if a python SimpleHTTPServer is running.
#' @examples webserver.status()

webserver.status <- function(lang=c('ruby', 'python')){
  x <- system(paste("ps aux"),intern = T)
  if (lang=='python'){
    running <- any(grepl("python -m SimpleHTTPServer",x))
  } else if (lang=='ruby'){
    running <- any(grepl("ruby", x))
  if (running) {
    cat("The webserver is running")
  } else {
    cat("The webserver is NOT running")
  }
}