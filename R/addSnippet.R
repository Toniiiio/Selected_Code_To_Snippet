add <- function(snippetName, code, filePath = "~/.R/snippets/r.snippets"){
  if(!file.exists(filePath)) stop("r.snippets file not found. Check the r.snippets path. Might have to make a first edit
                                  to file via Tools-Global Options-Code-Edit Snippets to make it available")

  data <- read.csv2(file = "~/.R/snippets/r.snippets",
                    header = FALSE, stringsAsFactors = FALSE)[, 1]
  idx <- grep("snippet ", data)
  takenNames <- sapply(strsplit(data[idx], "snippet "), "[", 2)

  if(snippetName %in% takenNames) stop("snippetName is already taken, please choose another one")

  snippetNameIn <- paste("snippet", snippetName)
  codeIn <- paste0("\t", code)
  data <- data.frame(
    text = paste(c(snippetNameIn, codeIn, as.character(data)), collapse = "\n"),
    stringsAsFactors = FALSE
  )

  write.table(file = filePath, data, row.names = FALSE, col.names = FALSE, quote = FALSE)
  file.edit(filePath)
}


addSnippet <- function(){
  library(shiny)
  library(miniUI)
  library(rstudioapi)

  code <- getActiveDocumentContext()$selection[[1]]$text
  name <- abbreviate(code, 5, named = FALSE)

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
      add(snippetName = input$snippetName,
          code = input$snippetCode,
          filePath = "~/.R/snippets/r.snippets")
      stopApp()
    })
  }
  viewer <- dialogViewer("Edit snippet and press 'Done',...", width = 600,
                         height = 320)
  runGadget(ui, server, viewer = viewer)
}


