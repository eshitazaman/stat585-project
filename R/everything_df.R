#' Generates a tibble of news with author, title, description, url, imageUrl, publication date, and content
#'
#' @param x is the JSON file obtained from  NewsApi.org
#'
#' @import rvest
#' @import xml2
#' @import tibble
#'

#' @return a tibble of news
#'
#' @export






everything_df <- function(x, verbose=FALSE) {
if (verbose) {
cat(x$name)
cat("\n")
}
author <- character()
title <- character()
description <- character()
url <- character()
imageURL <- character()
publishedAt <- character()
content <- character()
l<-length(x$articles)

for(i in 1:l){
if(is.null(x$articles[[i]]$author)){
author=c(author,NA)
}
author =c(author, x$articles[[i]]$author)

if(is.null(x$articles[[i]]$title)){
title=c(title,NA)
}
title=c(title, x$articles[[i]]$title)

if(is.null(x$articles[[i]]$description)){
description=c(description,NA)
}
description=c(description,x$articles[[i]]$description)

if(is.null(x$articles[[i]]$url)){
url=c(url,NA)
}
url=c(url,x$articles[[i]]$url)


if(is.null(x$articles[[i]]$imageURL)){
imageURL=c(imageURL,NA)
}
imageURL=c(imageURL,x$articles[[i]]$imageURL)

if(is.null(x$articles[[i]]$publishedAt)){
publishedAt=c(publishedAt,NA)
}
publishedAt=c(publishedAt,x$articles[[i]]$publishedAt)

if(is.null(x$articles[[i]]$content)){
content=c(content,NA)
}
content=c(content,x$articles[[i]]$content)
}

tibble (
title = title,
description = description,
content = content,
url = url,
author = author,
publishedAt = publishedAt
)

}