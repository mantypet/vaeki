source(here::here("R/entry_readers.R"))
library(ellmer)
library(glue)

county_kotiseutu_long.tbl <- read_kotiseutumuseot()
# county_kotiseutu_long.tbl <- readRDS(here::here("local_data/county_kotiseutu.rds"))

lmm_get_address <- function(user_prompt, system_prompt = "You are an expert on geospatial information systems and especially geolocating local Finnish Opea Air Museums and their addresses. As an output, provide address only in the following format: street address, zipcode, city, county") {
  chat <- suppressMessages(chat_google_gemini(system_prompt = system_prompt))
  user_prompt = user_prompt
  out <- chat$chat(user_prompt, echo = "none")
}

museum_names <- county_kotiseutu_long.tbl$museum_name
county_names<- county_kotiseutu_long.tbl$county_name
user_prompts <- glue("Find an address for {museum_names} in {county_names} Finland")[1:5] # test only as free rates exceeded: https://ai.google.dev/gemini-api/docs/rate-limits

museum_address <- lapply(user_prompts, lmm_get_address) |>
  unlist()

