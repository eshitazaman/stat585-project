


format_table <- function(x){
x1 <- x[,1]
x2 <- x[,2]
x3 <- x[,3]
x4 <- x[,4]
x5 <- x[,5]

image <- c()
for (i in 1:dim(x)[1]){
  image <-c(image,paste0('<img src=',x[i,5],' height=200','></img>'))
}

urls <- c()
for (i in 1:dim(x)[1]){
  urls <-c(urls,paste0("<a href='",x[i,4],"' target='_balank'>",x[i,4], "</a>"))}
dat <- NULL
dat <- data.frame(x1,x2,x3,urls, image)


return(dat)


}
