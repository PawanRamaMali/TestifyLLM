library(shiny)


function(input, output, session) {

  output$chat_response <- renderUI({
    # Start the chat fresh each time, as the UI is not a multi-turn conversation
    chat <- chat_openai(
      system_prompt = "You like an expert Tester, Answers should be concise and solve problems for Software Tester."
    )
    # Asynchronously get the (Markdown) results and render to HTML
    chat$chat_async("Answer this question:", input$user_query) %...>% markdown()
  }) |> bindEvent(input$ask_chat)

}
