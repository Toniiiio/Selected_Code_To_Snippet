library(shiny)
library(miniUI)
snippetApp <- function() {
  ui <- miniPage(
    gadgetTitleBar("Add RStudio snippets"),
    miniContentPanel(
      textInput("snippetName", "Snippet Name:", "newSnippetname1912"),
      textInput("snippetCode", "Snippet Code:", "print(92)")
    )
  )

  server <- function(input, output, session) {
    observeEvent(input$done, {
      stopApp()
    })

  }
  viewer <- dialogViewer("Add RStudio snippets")
  runGadget(ui, server, viewer = viewer)
}
# snippetApp()
