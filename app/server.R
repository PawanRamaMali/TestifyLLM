library(shiny)


function(input, output, session) {
  observeEvent(input$confirm_settings, {
    if (length(input$model_name) > 0 && nzchar(input$openai_api_key)) {
      Sys.setenv(LLM_MODELS = paste(input$model_name, collapse = ","))
      Sys.setenv(OPENAI_API_KEY = input$openai_api_key)
      output$status <- renderText("Environment variables updated successfully!")
    } else {
      output$status <- renderText("Please select at least one model and enter API Key.")
    }
  })

  output$chat_response <- renderUI({
    req(input$model_name, input$user_query)

    responses <- lapply(input$model_name, function(model) {
      chat <- chat_openai(
        system_prompt = paste("You are an expert Tester using", model, "model. Provide concise solutions for Software Testers.")
      )

      # Ensure chat object is valid before proceeding
      if (is.null(chat) || !is.function(chat$chat_async)) {
        return(HTML(paste("<b>Error:</b> Unable to process request with model:", model)))
      }

      response <- chat$chat_async("Answer this question:", input$user_query)

      # Ensure response is valid
      if (inherits(response, "promise")) {
        return(HTML(paste("<b>Processing response for model:</b>", model)))
      }

      return(HTML(paste("<b>", model, ":</b>", response)))
    })

    do.call(tagList, responses)
  }) |> bindEvent(input$ask_chat)
}
