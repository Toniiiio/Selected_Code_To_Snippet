#
# # snippetName <- "abc"
# # code <- "print(99)"
# addSnippet <- function(snippetName, code, filePath = "~/.R/snippets/r.snippets"){
#   if(!file.exists(filePath)) stop("r.snippets file not found. Check the r.snippets path. Might have to make a first edit
#                                   to file via Tools-Global Options-Code-Edit Snippets to make it available")
#
#   data <- read.csv2(file = "~/.R/snippets/r.snippets",
#                     header = FALSE, stringsAsFactors = FALSE)[, 1]
#   idx <- grep("snippet ", data)
#   takenNames <- sapply(strsplit(data[idx], "snippet "), "[", 2)
#
#   if(snippetName %in% takenNames) stop("snippetName is already taken, please choose another one")
#
#   snippetNameIn <- paste("snippet", snippetName)
#   codeIn <- paste0("\t", code)
#   data <- data.frame(
#     text = paste(c(snippetNameIn, codeIn, as.character(data)), collapse = "\n"),
#     stringsAsFactors = FALSE
#   )
#
#   write.table(file = filePath, data, row.names = FALSE, col.names = FALSE, quote = FALSE)
#   file.edit(filePath)
# }
#
# # snippetName = "abx"
# removeSnippet <- function(snippetName, filePath = "~/.R/snippets/r.snippets"){
#   if(!file.exists(filePath)) stop("r.snippets file not found. Check the r.snippets path. Might have to make a first edit
#                                   to file via Tools-Global Options-Code-Edit Snippets to make it available")
#
#   data <- read.csv2(file = "~/.R/snippets/r.snippets",
#                     header = FALSE, stringsAsFactors = FALSE)[, 1]
#   idx <- grep("snippet ", data)
#   takenNames <- sapply(strsplit(data[idx], "snippet "), "[", 2)
#   startIdx <- which(snippetName == takenNames)
#   if(!length(startIdx)){
#     warning(paste0("snippetName: ", snippetName, " was not included. Did not have to delete it."))
#     return()
#   }
#   toBeDel <- idx[startIdx]:(idx[startIdx + 1] - 1)
#   data <- data[-toBeDel]
#   data <- data.frame(
#     text = paste(as.character(data), collapse = "\n"),
#     stringsAsFactors = FALSE
#   )
#   write.table(file = filePath, data, row.names = FALSE, col.names = FALSE, quote = FALSE)
#   file.edit(filePath)
# }
#
# readSnippet <- function(snippetName, filePath = "~/.R/snippets/r.snippets"){
#   if(!file.exists(filePath)) stop("r.snippets file not found. Check the r.snippets path. Might have to make a first edit
#                                   to file via Tools-Global Options-Code-Edit Snippets to make it available")
#
#   data <- read.csv2(file = "~/.R/snippets/r.snippets",
#                     header = FALSE, stringsAsFactors = FALSE)[, 1]
#   idx <- grep("snippet ", data)
#   takenNames <- sapply(strsplit(data[idx], "snippet "), "[", 2)
#   startIdx <- which(snippetName == takenNames)
#   if(!length(startIdx)){
#     warning(paste0("Could not find snippetName: ", snippetName, "."))
#     return()
#   }
#   toBeDel <- idx[startIdx]:(idx[startIdx + 1] - 1)
#   return(
#     cat(paste(data[toBeDel], collapse = "\n"))
#   )
# }
#
# # rstudioapi:: getActiveDocumentContext()
# #
# # system.file(package = 'addinexamples')
# #
# # path <- "/home/rstudio/R/x86_64-pc-linux-gnu-library/3.5/addinexamples/rstudio/addins.dcf"
# # file.exists(path)
# # file.edit(path)
# #
# #
# # setwd("inst")
# # list.files()
# # dir.create("rstudio")
# # file.edit("addins.dcf")
