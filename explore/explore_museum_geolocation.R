source(here::here("R/entry_readers.R"))
library(ellmer)
library(glue)

county_kotiseutu_long.tbl <- read_kotiseutumuseot()
county_kotiseutu_long.tbl <- readRDS(here::here("local_data/county_kotiseutu.rds"))

chat <- chat_google_gemini(
  system_prompt = "You are an expert on geospatial information systems and especially geolocating local Finnish Opea Air Museums and their addresses"
  )

county <- county_kotiseutu_long.tbl$county_name[1]
museum <- county_kotiseutu_long.tbl$museum_name[1]
question <- glue("Find an address for {museum} in {county} Finland")

out <- chat$chat(question)
