add <- function(snippetName, code, filePath = "~/.R/snippets/r.snippets"){
  if(!file.exists(filePath)) stop("r.snippets file not found. Check the r.snippets path. Might have to make a first edit
                                  to file via Tools-Global Options-Code-Edit Snippets to make it available")

  data <- read.csv2(file = filePath,
                    header = FALSE, stringsAsFactors = FALSE)[, 1]
  idx <- grep("snippet ", data)
  takenNames <- sapply(strsplit(data[idx], "snippet "), "[", 2)

  if(snippetName %in% takenNames) return(FALSE)

  snippetNameIn <- paste("snippet", snippetName)
  code <- gsub("  ", "\t", code)
  code <- gsub("\n", "\n\t", code)
  codeIn <- paste0("\t", code)
  data <- data.frame(
    text = paste(c(snippetNameIn, codeIn, as.character(data)), collapse = "\n"),
    stringsAsFactors = FALSE
  )

  write.table(file = filePath, data, row.names = FALSE, col.names = FALSE, quote = FALSE)
  file.edit(filePath)
  return(TRUE)
}

SnippetName <- function(snippetName, filePath = "~/.R/snippets/r.snippets"){
  data <- read.csv2(file = filePath,
                    header = FALSE, stringsAsFactors = FALSE)[, 1]
  idx <- grep("snippet ", data)
  takenNames <- sapply(strsplit(data[idx], "snippet "), "[", 2)

  while(snippetName %in% takenNames){
    snippetName <- paste0(snippetName, 1)
  }

}

addSnippet <- function(){
  library(shiny)
  library(miniUI)
  library(rstudioapi)

  code <- getActiveDocumentContext()$selection[[1]]$text
  name <- SnippetName(substring(code, 1, 3))

  ui <- miniPage(
    gadgetTitleBar("Add RStudio snippets"),
    miniContentPanel(
      textInput("snippetName", "Snippet Name:", name),
      tags$style(type="text/css", "textarea {width:100%}"),
      tags$textarea(id = "snippetCode", rows = 8, code)
    )
  )

  server <- function(input, output, session) {

    observeEvent(input$done, {
      added <- add(snippetName = input$snippetName,
                   code = input$snippetCode,
                   filePath = "~/.R/snippets/r.snippets")
      if(added){
        stopApp()
      }else{
        showModal(modalDialog(
          title = "Snippet name taken",
          "Please choose another snippet name. This one is taken!"
        ))
      }
    })
  }

  viewer <- dialogViewer("Edit snippet and press 'Done',...", width = 600,
                         height = 320)
  runGadget(ui, server, viewer = viewer)
}
