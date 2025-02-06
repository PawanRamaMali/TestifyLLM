library(shiny)

ui <- page_sidebar(
  title = "Interactive chat with async",
  sidebar = sidebar(
    title = "Configuration",
    textInput("model_name", "Enter LLM Model to use:"),
    textInput("openai_api_key", "Enter OpenAI API Key"),
    input_task_button("confirm_model", label = "Update")
  ),
  card(
    card_header("The chat's response"),
    uiOutput("chat_response"),
    textInput("user_query", "Enter query:"),
    input_task_button("ask_chat", label = "Ask the chat")
  )
)
