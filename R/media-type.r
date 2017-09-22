#' Sand the rough edges off of bare, scraped media (MIME) types into a smooth data frame
#'
#' @md
#' @param media_types character vector of media (MIME) types
#' @return `data.frame` (tibble)
#' @export
#' @references [RFC 7231](https://tools.ietf.org/html/rfc7231#section-3.1.1.1)
#' @examples
#' content_type <- c("text/html; charset=utf-8", "text/css",
#'                   "text/javascript; charset=UTF-8", "text/javascript",
#'                   "application/x-javascript", "text/plain; charset=utf-8")
#' normalize_media_types(content_type)
normalize_media_types <- function(media_types) {

  # per <https://tools.ietf.org/html/rfc7231#section-3.1.1.1>
  #
  # - all whitespace is optional
  # - the entire string is case-insensitive
  # - there can be 0 or more params

  media_types <- stri_replace_all_fixed(media_types, " ", "")
  media_types <- stri_trans_tolower(media_types)

  # separate media type from the parameters
  media_types <- stri_split_fixed(media_types, ";")

  # extract the media type
  media_type <- sapply(media_types, `[[`, 1)

  # split media type into type and subtype
  type_and_subtype <- stri_split_fixed(media_type, "/", 2, simplify = TRUE)

  # now work on the params
  lapply(media_types, function(.x) {

    .x <- .x[-1] # throw away the mime type

    idx <- which(.x != "") # remove empty values (if any)

    if (length(idx)>0) { # if we have values, separate into key/value pairs

      .x <- .x[idx]
      .x <- stri_split_fixed(.x, "=", 2, simplify=TRUE)
      .x <- tibble::as_data_frame(.x)
      .x <- setNames(.x, c("key", "value"))

      list(.x)

    } else {
      list()
    }

  }) -> params

  # return a data frame with type|subtype|list col of params

  ret <- tibble::as_data_frame(type_and_subtype)
  ret <- setNames(ret, c("type", "subtype"))

  ret$params <- params

  ret

}
