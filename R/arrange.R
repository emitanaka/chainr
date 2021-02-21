#' Arrange data frames within chain by the column values
#'
#' @param .chain A chain.
#' @param .dataset The name of the data frame or selection verbs.
#' @param ... Similar to `dplyr::arrange`.
#'
#' @importFrom dplyr arrange
#' @export
arrange.chain <- function(.chain, .dataset, ...) {
  .dataset <- enexpr(.dataset)
  anneal(.chain, !!.dataset, arrange, ..., .env = caller_env(n = 2))
}

