library(shiny)


function(input, output, session) {

  observeEvent(input$confirm_settings, {
    if (nzchar(input$model_name) && nzchar(input$openai_api_key)) {
      Sys.setenv(LLM_MODEL = input$model_name)
      Sys.setenv(OPENAI_API_KEY = input$openai_api_key)
      output$status <- renderText("Environment variables updated successfully!")
    } else {
      output$status <- renderText("Please enter both Model Name and API Key.")
    }
  })

  output$chat_response <- renderUI({
    # Start the chat fresh each time, as the UI is not a multi-turn conversation
    chat <- chat_openai(
      system_prompt = "You like an expert Tester, Answers should be concise and solve problems for Software Tester."
    )
    # Asynchronously get the (Markdown) results and render to HTML
    chat$chat_async("Answer this question:", input$user_query) %...>% markdown()
  }) |> bindEvent(input$ask_chat)

}
