library(here)
here::i_am("R-NLP/gpt-nlp.R")
source("R-NLP/myopenai.R")



gpt_extract_vec <- function(instruction = 'Extract city name in the R vector', 
                            x = c("Hello, Bangkok", "Hi, Paris"),
                            model = "gpt-3.5-turbo"
                            ) {
  
  prompt_system <- readLines_collapsed(here("R-NLP/prompt/prompt-sys-1.md"))
  strvec <- rvec_to_strvec(x)
  prompt_user <- paste(instruction, strvec, sep = "\n\n")
  
  out_strvec <- chat_with_gpt(prompt_user, prompt_system, model = model)
  out_rvec <- strvec_to_rvec(out_strvec)
  

}


rvec_to_strvec <- function(x) {
  
  x_surround <- ifelse(is.na(x), x, paste0('"', x, '"'))
  x_collapsed <- paste(x_surround, collapse = ", ")
  paste0("c(", x_collapsed, ")")
}

strvec_to_rvec <- function(str) {
  # Parse the string to an R expression
  expr <- parse(text = str)
  # Evaluate the expression to get the actual R vector
  rvec <- eval(expr)
  rvec
}


readLines_collapsed <- function(con, ...) {
  paste(readLines(con, warn = F, ...), collapse = "\n")
}
