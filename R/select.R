#' @importFrom dplyr select
#' @export
select.chain <- function(.chain, .dataset, ...) {
  .dataset <- enexpr(.dataset)
  anneal(.chain, !!.dataset, select, ..., .env = caller_env(n = 2))
}

#' @export
select_links <- function(.chain, ...) {
  loc_data <- tidyselect::eval_select(expr(c(...)), .chain)
  data_names <- names(loc_data)
  .chain[data_names]
}
