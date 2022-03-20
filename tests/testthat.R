library(testthat)

message("Running unit tests...")
test_dir(
  path = "testthat",
  env = shiny::loadSupport(),
  reporter = c("summary", "fail"),
  globalrenv = globalenv()
)