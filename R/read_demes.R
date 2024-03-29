#' Load and validate a Demes model
#'
#' This function reads a Demes model from a YAML file or a literal YAML string,
#' validates the model, and returns it as a fully instantiated R object.
#'
#' See the Demes specification document for more details about the Demes format
#' <https://github.com/popsim-consortium/demes-spec/>. Many example YAML Demes
#' files can be found at <https://github.com/popsim-consortium/demes-spec/tree/main/test-cases/valid>.
#'
#' @param file Either a path to a YAML file or a \link[base]{connection}
#' @param text If a \code{file} is not provided, Demes YAML input is
#'   read as a literal string given in the \code{text}
#' @return A fully instantiated Demes model as a nested R list
#' @export
#'
#' @examples
#' path <- system.file("extdata/yaml", "minimal_01.yaml", package = "demes")
#' demes1 <- read_demes(file = path)
#'
#' yaml_string <- "time_units: generations\ndemes:\n  - name: a\n    epochs:\n    - start_size: 100"
#' demes2 <- read_demes(text = yaml_string)
read_demes <- function(file, text){
  if (missing(file) && !missing(text)) {
    inp <- yaml::read_yaml(text = text)
  } else if (!missing(file) && missing(text)) {
    if (!file.exists(file))
      stop("A YAML file not found at the given path: ", file, call. = FALSE)
    inp <- yaml::read_yaml(file = file)
  } else {
    stop("Either a path to a YAML file or a YAML string must be given as input", call. = FALSE)
  }

  demes <- validate_demes(inp)
  demes <- name_demes(demes)
  demes <- convert_infinity(demes)

  return(demes)
}
