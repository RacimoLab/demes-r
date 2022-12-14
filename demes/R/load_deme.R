filepath <- "../ex03.yaml"


#' Load and Validate a Demes Model
#'
#' More description
#'
#' @param filepath
#'
#' @return \code{out}
#' @export
#'
#' @examples
load_deme <- function(filepath){

  inp <- yaml::read_yaml(filepath)
  out <- inp


  # Check for time_units and generation_time
  if (is.null(inp$time_units)){
    out$time_units <- "generations"
  }


  if (is.null(inp$doi)){
    out$doi<- list()
  }

  # if (is.null(inp$metadata)){
  #   out$metadata <- list()
  # }

  for (i in 1:length(inp$demes)){
    if (is.null(inp$demes[[i]]$ancestors)){
      out$demes[[i]]$ancestors <- list()
    }

    # Check for description or set default
    if (is.null(inp$demes[[i]]$description)){
      out$demes[[i]]$description <-  ''
    }

    if (is.null(inp$demes[[i]]$proportions)){
      out$demes[[i]]$proportions <- list()
    }

    comparison_group <- c("end_time", "end_size", "start_size", "size_function", "selfing_rate", "cloning_rate")
    for(j in 1:length(inp$demes[[i]]$epochs)){
      present_epoch <- c(names(inp$demes[[i]]$epochs[[j]]))
      missing_epoch <- setdiff(comparison_group, present_epoch)

      if (is.null(inp$demes[[i]]$epochs)){
        out$demes[[i]]$epochs <- list()
        out$demes[[i]]$epochs[[1]]$end_time <- 0
        out$demes[[i]]$epochs[[1]]$start_size <- 0
        out$demes[[i]]$epochs[[1]]$end_size <- 0
        out$demes[[i]]$epochs[[1]]$size_function <- "constant"
        out$demes[[i]]$epochs[[1]]$selfing_rate <- 0
        out$demes[[i]]$epochs[[1]]$cloning_rate <- 0
      } else if (length(missing_epoch) != 0){

        if(is.null(inp$demes[[i]]$epochs[[1]]$end_time)){
          out$demes[[i]]$epochs[[1]]$end_time <- 0
        }

        if(is.null(inp$demes[[i]]$epochs[[1]]$end_size)){
          out$demes[[i]]$epochs[[1]]$end_time <- out$demes[[i]]$epochs[[1]]$start_size
        }

        if(is.null(inp$demes[[i]]$epochs[[1]]$size_function)){
          out$demes[[i]]$epochs[[1]]$size_function <- "constant"
        }
        if(is.null(inp$demes[[i]]$epochs[[1]]$selfing_rate)){
          out$demes[[i]]$epochs[[1]]$selfing_rate <- 0
        }
        if(is.null(inp$demes[[i]]$epochs[[1]]$cloning_rate)){
          out$demes[[i]]$epochs[[1]]$cloning_rate <- 0
        }

      }
    }

    if (is.null(inp$migrations)){
      out$migrations <- list()
    }

    if (is.null(inp$pulses)){
      out$pulses <- list()
    }
  }

  return(out)
}

test_out <- load_deme(filepath)
#
# metadata: {}
# demes:
#   - name: A
# description: ''
# start_time: .inf
# ancestors: []
# proportions: []
# epochs:
#   - {end_time: 0, start_size: 1000, end_size: 1000, size_function: constant, selfing_rate: 0,
#     cloning_rate: 0}
# migrations: []
# pulses: []

# Currently the python does not print the doi, but it should, the internal python representation and the printed python thing do not match, so use that for comparison
