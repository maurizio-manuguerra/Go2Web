#' @title webserver.start
#' @description This function publish the content of the current directory on a web server. Technically, 
#' it runs the system command "python -m SimpleHTTPServer 8004 &>/dev/null" or its ruby counterpart. The default port is 8004 and 
#' every output is redirected to /dev/null (i.e. not shown to the user). Both options can be changed by the user.
#' @param port Defaults to 8004
#' @param redirect.to.null Defaults to TRUE
#' @examples webserver.start()

webserver.start <- function(port=27360, stdout=FALSE, stderr=FALSE, lang=c('python', 'ruby')){
  cmd= match.arg(lang)
  redirect=""
  redirect =" > ~/temp/little-web-server.log 2>&1"
  if (cmd=='python'){
    opt <- paste("-m SimpleHTTPServer ", as.character(port), redirect, " &", sep="")
  } else if (cmd=='ruby'){
    opt <- paste("-run -ehttpd . -p ", as.character(port), redirect, " &", sep="")
  }
  try(webserver.stop(), silent=T)
  system2(cmd, args=opt, stdout=stdout, stderr=stderr)
  .Last <<- eval(parse(text=paste("function() try(webserver.stop(lang='",cmd,"'),silent=T)",sep="")))
}



#' @title webserver.stop
#' @description This function stops the web server started with ``webserver.start()''. The default port is 8004 and can be changed by the user to whatever port the server is running on.
#' @param port Defaults to 8004
#' @examples webserver.stop()

webserver.stop <- function(lang=c('ruby', 'python')){
  lang= match.arg(lang)
  if (lang=='python'){
    cmd <- "pkill -f 'python -m SimpleHTTPServer'"
  } else if (lang=='ruby'){
    cmd <- "pkill -f 'ruby -ehttpd'"
  }
  system(cmd)
  if (exists(".Last")) rm(.Last, envir=.GlobalEnv)
}

#' @title webserver.status
#' @description This function checks if a python SimpleHTTPServer is running.
#' @examples webserver.status()

webserver.status <- function(lang=c('ruby', 'python')){
  lang= match.arg(lang)
  x <- system(paste("ps aux"),intern = T)
  if (lang=='python'){
    running <- any(grepl("python -m SimpleHTTPServer",x))
  } else if (lang=='ruby'){
    running <- any(grepl("ruby", x))
  }
  if (running) {
    cat("The webserver is running")
  } else {
    cat("The webserver is NOT running")
  }
}