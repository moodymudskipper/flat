#' Produce script reproduce a package
#'
#' Since the file produce is a self contained flat file you can email it and source
#' it in the desired folder. {flat} is not needed on the recipient machine.
#'
#' We ignore :
#'
#' - hidden `.Rproj.user*` files
#' - git files
#' - binary files
#' - files under man/ (we assume they can be rebuilt with roxygen)
#' - README.md (we assume it can be rebuilt from a README.Rmd)
#' - .Rhistory
#' - testthat snapshots
#'
#' We can do a bi
#'
#' @param dir source dir, current dir by default.
#' @param file destination path, if absent the script is printed to the comnsole.
#'
#' @return Returns `NULL` invisibly, called for side effects.
#' @export
flatten_package <- function(dir = ".", file = "") {
  all_files <- list.files(dir, all.files = TRUE, recursive = TRUE)
  # ignore hidden project files
  all_files <- grep("\\.Rproj\\.user", all_files, invert = TRUE, value = TRUE)
  # ignore git files
  all_files <- grep("\\.git", all_files, invert = TRUE, value = TRUE)
  # ignore snapshot tests
  all_files <- grep("_snaps/", all_files, invert = TRUE, value = TRUE)
  # ignore binary files
  all_files <- Filter(Negate(is.binary), all_files)
  # ignore doc, assuming we'll build it with roxygen
  all_files <- grep("\\.Rd", all_files, invert = TRUE, value = TRUE)
  # ignore .Rhistory
  all_files <- setdiff(all_files, c(".Rhistory", "README.md"))

  all_dirs <- list.dirs(dir, recursive = TRUE)
  all_dirs <- grep("\\.Rproj\\.user", all_dirs, invert = TRUE, value = TRUE)
  all_dirs <- grep("\\.git", all_dirs, invert = TRUE, value = TRUE)
  all_dirs <- setdiff(all_dirs, c(".", "man"))


  script_dirs <- sprintf('dir.create("%s")', all_dirs)
  script_dirs <- c(sprintf("#### create dirs %s\n", strrep("-", 63)), script_dirs)
  script_dirs <- paste(script_dirs, collapse = "\n")
  script_files <- sprintf(
    '\n#### %s %s\n\nwriteLines(con = "%s", "%s")\n',
    all_files,
    strrep("-", 74 - nchar(all_files)),
    all_files,
    vapply(all_files, function(x) {
      lines <- readLines(x)
      lines <- gsub("\\\\", "\\\\\\\\", lines)
      lines <- gsub("\"", "\\\\\"", lines)
      lines <- gsub("'", "\\'", lines)
      paste(lines, collapse = "\n")
      },
      FUN.VALUE = character(1))
  )
  script <- c(script_dirs, "\n", script_files)
  cat(script, file = file)
}

is.binary <- function(file, max = 1000){
  f <- file(file, "rb", raw = TRUE)
  b <- readBin(f, "int", max, size = 1, signed = FALSE)
  max(b)>128
}
