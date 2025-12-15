source(here::here("R/global.R"))

drive_auth_configure(
  path = here::here("../../_eivarmisteta/oauth-client-id/client_secret_982746612532-q683tb66lnc4e0f5tcfqe3mmv7umbicd.apps.googleusercontent.com.json")
)

drive_oauth_client()

drive_auth()
