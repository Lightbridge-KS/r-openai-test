library(openai)

client <- OpenAI()

chat_with_gpt <- function(prompt_user, 
                          prompt_system = "You are a helpful assistant.", 
                          model = "gpt-3.5-turbo"
                          ){
  completion <- my_chat_completion(model = model, 
                                   prompt_user = prompt_user, 
                                   prompt_system = prompt_system)
  msg_content <-  completion$choices[[1]]$message$content
  msg_content
}


chat_with_gpt3 <- function(prompt_user, prompt_system = "You are a helpful assistant."){
  completion <- my_chat_completion(model = "gpt-3.5-turbo", 
                                   prompt_user = prompt_user, 
                                   prompt_system = prompt_system)
  msg_content <-  completion$choices[[1]]$message$content
  msg_content
}


my_chat_completion <- function(model = "gpt-3.5-turbo",
                               seed = 1, temperature = 1,
                               prompt_system = "You are a helpful assistant.",
                               prompt_user = "Hello"
                               ) {
  
  completion <- client$chat$completions$create(
    model = model,
    seed = seed,
    temperature = temperature,
    messages = list(
      list("role" = "system", "content" = prompt_system),
      list("role" = "user", "content" = prompt_user)
      )
  )
  completion
}

get_msg_content <- function(completion) {
  completion$choices[[1]]$message$content
}