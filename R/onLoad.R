.onLoad <- function(libname = find.package("seastar"), pkgname = "seastar") {
  .autoUp("seastar")
}

.autoUp<-function(pack){
  # mostly borrowed from Adam Lee Perelman's answer here: http://stackoverflow.com/a/33738713
  # pack<-gsub("[:]{2}[A-Z|a-z|0-9]+","",deparse(sys.call()[[1]]))
  testUrl <- function(url) {
    out <- tryCatch(
      {
        readLines(con=url, warn=FALSE,n=1)
      },error=function(cond) {
        return(NA)
      },warning=function(cond) {
        return(FALSE)
      },finally={})
    return(out)
  }
  pkg<-packageDescription(pack)$URL
  GETS<-"https://raw.githubusercontent.com/JARS3N/seastar/master/DESCRIPTION"
  if (testUrl(GETS)==FALSE){
    return(
      message("Not able to communicate with repository & unable to check for updates")
           )}
  ongit<- gsub("Version: ","",grep("Version: ",readLines(GETS,warn=F),value=T))
  if (numeric_version(ongit)>utils::packageVersion(pack)){
    devtools::install_github("https://github.com/JARS3N/seastar",quiet=TRUE)
  }
}
