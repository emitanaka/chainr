
#' @importFrom dplyr mutate
#' @export
mutate.chain <- function(.chain, .dataset, ...) {
  .dataset <- enexpr(.dataset)
  anneal(.chain, !!.dataset, mutate, ..., .env = caller_env(n = 2))
}

