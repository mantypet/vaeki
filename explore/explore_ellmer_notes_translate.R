source(here::here("R/entry_readers.R"))
library(ellmer)
library(glue)

sources <- read_finnish_stones_sources()

lmm_clean_finnish <- function(user_prompt, system_prompt = "You are an expert on Finnish language and old dialects. Clean the following text from any OCR errors, typos, and mistakes. Return only the cleaned text without any additional comments or explanations. If prompt is empty return empty.") {
  chat <- suppressMessages(chat_google_gemini(system_prompt = system_prompt))
  user_prompt = user_prompt
  out <- chat$chat(user_prompt, echo = "none")
  Sys.sleep(1)  # To avoid rate limiting
}

notes_raw <- sources$notes_raw_fi

notes_clean <- map_chr(notes_raw, lmm_clean_finnish, .progress = interactive())

