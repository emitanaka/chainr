
#' Link data frames as a chain
#'
#' @param ... A name-value pair where value is a data frame. The supplied
#' data frame should be linked by a key. The link is determined automatically by
#' the intersection of the column names but may be set manually by `link`.
#'
#' @examples
#' vs_info <- data.frame(engine = c(0, 1), info = c("flat", "unknown"))
#' chain(original = mtcars,
#'       vs_total = group_by(original, vs) %>%
#'                   summarise(across(everything(), sum)),
#'       vs_dict = data.frame(vs = c(0, 1), engine = c("V-shaped", "Straight")),
#'       vs_info = link(vs_info, original, .by = c(vs = "engine")))
#'
#'
#'
#' @export
chain <- function(..., .class = NULL, .return = c("list", "env")) {
  .return <- match.arg(.return)
  dots <- enquos(...)
  dots_names <- names(dots)
  auto_named_dots <- names(enquos(..., .named = TRUE))

  if (length(dots) == 0L) {
    return(NULL)
  }

  out <- list()
  for(i in seq_along(dots)) {
      not_named <- (is.null(dots_names) || dots_names[i] == "")
      name <- if (not_named) auto_named_dots[i] else dots_names[i]
      out[[name]] <- eval_tidy(dots[[i]], out)
  }
  if(.return=="env") {
    out <- new_environment(data = out)
  }
  class(out) <- c(.class, "chain", class(out))
  out
}

#' @export
format.chain <- function(x, ...) {
  if(is_environment(x)) {
    out <- as.list(x)
    attributes(out) <- attributes(x)
  } else {
    out <- x
  }
  out
}

#' @export
print.chain <- function(x, ...) {
  print.default(format(x))
}


#' @export
link <- function(.data, ..., .by = NULL) {
  dots <- enquos(...)
  dots_names <- names(dots)
  link <- list()
  link[dots_names] <- .by
  attr(.data, "link") <- link
  .data
}


