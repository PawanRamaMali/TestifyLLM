library(shiny)

ui <- page_sidebar(
  title = "Interactive chat with multiple LLM models",
  sidebar = sidebar(
    title = "Configuration",
    selectInput("model_name", "Select LLM Model(s) to use:", choices = c("Model 1", "Model 2", "Model 3"), multiple = TRUE),
    textInput("openai_api_key", "Enter OpenAI API Key"),
    input_task_button("confirm_settings", label = "Update"),
    verbatimTextOutput("status")
  ),
  card(
    card_header("The chat's response"),
    uiOutput("chat_response"),
    textInput("user_query", "Enter query:"),
    input_task_button("ask_chat", label = "Ask the chat")
  )
)
