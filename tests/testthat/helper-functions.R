# Set up a Python environment for the purpose of running# unit tests against
# the reference implementation of Demes
setup_env <- function(PYTHON_ENV = "demes-r"){
  if (!dir.exists(reticulate::miniconda_path()))
    reticulate::install_miniconda()

  if (!PYTHON_ENV %in% reticulate::conda_list()$name)
    reticulate::conda_install(
      envname = PYTHON_ENV,
      packages = c("ruamel.yaml"),
      pip = FALSE
    )

  reticulate::use_condaenv(PYTHON_ENV, required = TRUE)
}

# Return a (re-usable within a single R session) directory with downloaded
# Demes specification repository (scripts and test files)
get_spec_dir <- function() {
  # note: can be changed to a fixed location for easier development work
  file.path(tempdir(), "demes-spec-44803a99f28209560948acab1a6b4106ec2c0283")
}

# Download Demes specification repository containing Python scripts and test files
setup_demes_spec <- function() {
  if (!dir.exists(get_spec_dir())) {
    tmp_dir <- tempdir()
    demes_spec_zip <- tempfile()
    download.file(
      url = "https://github.com/popsim-consortium/demes-spec/archive/44803a99f28209560948acab1a6b4106ec2c0283.zip",
      destfile = demes_spec_zip, quiet = TRUE
    )
    unzip(demes_spec_zip, exdir = tempdir())
  }
}

# Parse a YAML test file using the Python Demes reference implementation
# (assuming a conda environment has already been activated), creating a json file
parse_ref <- function(input_file){
  path_ref_implementation <- file.path(get_spec_dir(), "reference_implementation", "resolve_yaml.py")
  path_preparsed_file <- file.path(tempdir(), gsub("yaml", "json", basename(input_file)))

  py_command <- paste("import os; os.system('python", path_ref_implementation, input_file, ">", path_preparsed_file, "')")
  reticulate::py_run_string(py_command)

  return(path_preparsed_file)
}

# Get path to a valid test file in the Demes specification directory
get_test_file <- function(file) {
  file.path(get_spec_dir(), "test-cases", "valid", file)
}

# Get path to an invalid test file in the Demes specification directory
get_invalid_test_file <- function(file) {
  file.path(get_spec_dir(), "test-cases", "invalid", file)
}
