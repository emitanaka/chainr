
#' @importFrom dplyr mutate
#' @export
mutate_in <- function(.chain, .dataset, ...) {
  .dataset <- enexpr(.dataset)
  anneal(.chain, !!.dataset, mutate, ..., .env = caller_env(n = 2))
}

