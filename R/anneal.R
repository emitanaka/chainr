
#' @export
anneal <- function(.chain, .dataset, .f, ..., .env = NULL) {
  .env <- .env %||% caller_env(n = 1)
  loc_data <- tidyselect::eval_select(enexpr(.dataset), .chain, env = .env)
  data_names <- names(loc_data)
  .f <- as_function(.f)
  out <- .chain
  for(aname in data_names) {
    if(is_lambda(.f)) {
      out[[aname]] <- .f(.x = out[[aname]], ...)
    } else {
      out[[aname]] <- .f(out[[aname]], ...)
    }
  }
  out
}
