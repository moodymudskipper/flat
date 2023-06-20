
# flat

{flat} makes your package into a script you can source to recreate it,
this allows you to email a flat file when emailing a compressed file is
problematic.

It has a single function `flat::flatten_package()` that takes a package
folder (defaults to current folder) and an output file (defaults to
printing to console).

{flat} is not needed on the recipient machine.

We ignore :

- hidden `.Rproj.user*` files
- git files
- binary files
- files under man/ (we assume they can be rebuilt with roxygen)
- README.md (we assume it can be rebuilt from a README.Rmd)
- .Rhistory
- testthat snapshots

## Installation

Install with:

``` r
devtools::install("moodymudskipper/flat")
```

## Example

``` r
flat::flatten_package()
#> #### create dirs ---------------------------------------------------------------
#> 
#> dir.create("./.git")
#> dir.create("./.git/hooks")
#> dir.create("./.git/info")
#> dir.create("./.git/logs")
#> dir.create("./.git/logs/refs")
#> dir.create("./.git/logs/refs/heads")
#> dir.create("./.git/logs/refs/remotes")
#> dir.create("./.git/logs/refs/remotes/origin")
#> dir.create("./.git/objects")
#> dir.create("./.git/objects/19")
#> dir.create("./.git/objects/1c")
#> dir.create("./.git/objects/1d")
#> dir.create("./.git/objects/32")
#> dir.create("./.git/objects/42")
#> dir.create("./.git/objects/44")
#> dir.create("./.git/objects/46")
#> dir.create("./.git/objects/58")
#> dir.create("./.git/objects/68")
#> dir.create("./.git/objects/69")
#> dir.create("./.git/objects/83")
#> dir.create("./.git/objects/8b")
#> dir.create("./.git/objects/ac")
#> dir.create("./.git/objects/af")
#> dir.create("./.git/objects/b6")
#> dir.create("./.git/objects/c6")
#> dir.create("./.git/objects/info")
#> dir.create("./.git/objects/pack")
#> dir.create("./.git/refs")
#> dir.create("./.git/refs/heads")
#> dir.create("./.git/refs/remotes")
#> dir.create("./.git/refs/remotes/origin")
#> dir.create("./.git/refs/tags")
#> dir.create("./man")
#> dir.create("./R") 
#>  
#> #### .git/config ---------------------------------------------------------------
#> 
#> writeLines(con = ".git/config", "[core]
#>  bare = false
#>  repositoryformatversion = 0
#>  filemode = true
#>  ignorecase = true
#>  precomposeunicode = true
#>  logallrefupdates = true
#> [remote \"origin\"]
#>  url = https://github.com/moodymudskipper/flat.git
#>  fetch = +refs/heads/*:refs/remotes/origin/*
#> [branch \"main\"]
#>  remote = origin
#>  merge = refs/heads/main")
#>  
#> #### .git/description ----------------------------------------------------------
#> 
#> writeLines(con = ".git/description", "Unnamed repository; edit this file 'description' to name the repository.")
#>  
#> #### .git/HEAD -----------------------------------------------------------------
#> 
#> writeLines(con = ".git/HEAD", "ref: refs/heads/main")
#>  
#> #### .git/hooks/README.sample --------------------------------------------------
#> 
#> writeLines(con = ".git/hooks/README.sample", "#!/bin/sh
#> #
#> # Place appropriately named executable hook scripts into this directory
#> # to intercept various actions that git takes.  See `git help hooks` for
#> # more information.")
#>  
#> #### .git/info/exclude ---------------------------------------------------------
#> 
#> writeLines(con = ".git/info/exclude", "# File patterns to ignore; see `git help ignore` for more information.
#> # Lines that start with '#' are comments.")
#>  
#> #### .git/logs/HEAD ------------------------------------------------------------
#> 
#> writeLines(con = ".git/logs/HEAD", "0000000000000000000000000000000000000000 8b5504804a515f941793b3433ad2fd1ee472a455 Antoine Fabri <antoine.fabri@gmail.com> 1687265521 +0200   commit (initial): Initial commit
#> 8b5504804a515f941793b3433ad2fd1ee472a455 1d10aa0955931970c9e23cc2e3f03c8b8e761f19 Antoine Fabri <antoine.fabri@gmail.com> 1687265563 +0200   commit: Add GitHub links to DESCRIPTION")
#>  
#> #### .git/logs/refs/heads/main -------------------------------------------------
#> 
#> writeLines(con = ".git/logs/refs/heads/main", "0000000000000000000000000000000000000000 8b5504804a515f941793b3433ad2fd1ee472a455 Antoine Fabri <antoine.fabri@gmail.com> 1687265521 +0200    commit (initial): Initial commit
#> 8b5504804a515f941793b3433ad2fd1ee472a455 1d10aa0955931970c9e23cc2e3f03c8b8e761f19 Antoine Fabri <antoine.fabri@gmail.com> 1687265563 +0200   commit: Add GitHub links to DESCRIPTION")
#>  
#> #### .git/logs/refs/remotes/origin/main ----------------------------------------
#> 
#> writeLines(con = ".git/logs/refs/remotes/origin/main", "0000000000000000000000000000000000000000 1d10aa0955931970c9e23cc2e3f03c8b8e761f19 Antoine Fabri <antoine.fabri@gmail.com> 1687265564 +0200   update by push")
#>  
#> #### .git/refs/heads/main ------------------------------------------------------
#> 
#> writeLines(con = ".git/refs/heads/main", "1d10aa0955931970c9e23cc2e3f03c8b8e761f19")
#>  
#> #### .git/refs/remotes/origin/main ---------------------------------------------
#> 
#> writeLines(con = ".git/refs/remotes/origin/main", "1d10aa0955931970c9e23cc2e3f03c8b8e761f19")
#>  
#> #### .gitignore ----------------------------------------------------------------
#> 
#> writeLines(con = ".gitignore", ".Rproj.user
#> inst/doc
#> .Rhistory
#> .Rdata
#> .httr-oauth
#> .DS_Store
#> .quarto")
#>  
#> #### .Rbuildignore -------------------------------------------------------------
#> 
#> writeLines(con = ".Rbuildignore", "^flat\\.Rproj$
#> ^\\.Rproj\\.user$
#> ^README\\.Rmd$
#> ^LICENSE\\.md$")
#>  
#> #### DESCRIPTION ---------------------------------------------------------------
#> 
#> writeLines(con = "DESCRIPTION", "Package: flat
#> Title: Flatten package to script you can source to recover the package
#> Version: 0.0.0.9000
#> Authors@R: 
#>     person(\"Antoine\", \"Fabri\", , \"antoine.fabri@gmail.com\", role = c(\"aut\", \"cre\"))
#> Description: Flatten package to script you can source to recover the package
#> License: MIT + file LICENSE
#> Encoding: UTF-8
#> Roxygen: list(markdown = TRUE)
#> RoxygenNote: 7.2.3
#> Suggests: 
#>     knitr,
#>     rmarkdown
#> VignetteBuilder: knitr
#> URL: https://github.com/moodymudskipper/flat
#> BugReports: https://github.com/moodymudskipper/flat/issues")
#>  
#> #### flat.Rproj ----------------------------------------------------------------
#> 
#> writeLines(con = "flat.Rproj", "Version: 1.0
#> 
#> RestoreWorkspace: No
#> SaveWorkspace: No
#> AlwaysSaveHistory: Default
#> 
#> EnableCodeIndexing: Yes
#> UseSpacesForTab: Yes
#> NumSpacesForTab: 2
#> Encoding: UTF-8
#> 
#> RnwWeave: Sweave
#> LaTeX: pdfLaTeX
#> 
#> AutoAppendNewline: Yes
#> StripTrailingWhitespace: Yes
#> LineEndingConversion: Posix
#> 
#> BuildType: Package
#> PackageUseDevtools: Yes
#> PackageInstallArgs: --no-multiarch --with-keep.source
#> PackageRoxygenize: rd,collate,namespace")
#>  
#> #### LICENSE -------------------------------------------------------------------
#> 
#> writeLines(con = "LICENSE", "YEAR: 2023
#> COPYRIGHT HOLDER: flat authors")
#>  
#> #### LICENSE.md ----------------------------------------------------------------
#> 
#> writeLines(con = "LICENSE.md", "# MIT License
#> 
#> Copyright (c) 2023 flat authors
#> 
#> Permission is hereby granted, free of charge, to any person obtaining a copy
#> of this software and associated documentation files (the \"Software\"), to deal
#> in the Software without restriction, including without limitation the rights
#> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#> copies of the Software, and to permit persons to whom the Software is
#> furnished to do so, subject to the following conditions:
#> 
#> The above copyright notice and this permission notice shall be included in all
#> copies or substantial portions of the Software.
#> 
#> THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#> SOFTWARE.")
#>  
#> #### NAMESPACE -----------------------------------------------------------------
#> 
#> writeLines(con = "NAMESPACE", "# Generated by roxygen2: do not edit by hand
#> 
#> export(flatten_package)")
#>  
#> #### R/flatten.R ---------------------------------------------------------------
#> 
#> writeLines(con = "R/flatten.R", "#' Produce script reproduce a package
#> #'
#> #' Since the file produce is a self contained flat file you can email it and source
#> #' it in the desired folder. {flat} is not needed on the recipient machine.
#> #'
#> #' We ignore :
#> #'
#> #' - hidden `.Rproj.user*` files
#> #' - git files
#> #' - binary files
#> #' - files under man/ (we assume they can be rebuilt with roxygen)
#> #' - README.md (we assume it can be rebuilt from a README.Rmd)
#> #' - .Rhistory
#> #' - testthat snapshots
#> #'
#> #' We can do a bi
#> #'
#> #' @param dir source dir, current dir by default.
#> #' @param file destination path, if absent the script is printed to the comnsole.
#> #'
#> #' @return Returns `NULL` invisibly, called for side effects.
#> #' @export
#> flatten_package <- function(dir = \".\", file = \"\") {
#>   all_files <- list.files(dir, all.files = TRUE, recursive = TRUE)
#>   # ignore hidden project files
#>   all_files <- grep(\"\\\\.Rproj\\\\.user\", all_files, invert = TRUE, value = TRUE)
#>   # ignore git files
#>   all_files <- grep(\"\\\\.git\", all_files, invert = TRUE, value = TRUE)
#>   # ignore snapshot tests
#>   all_files <- grep(\"_snaps/\", all_files, invert = TRUE, value = TRUE)
#>   # ignore binary files
#>   all_files <- Filter(Negate(is.binary), all_files)
#>   # ignore doc, assuming we'll build it with roxygen
#>   all_files <- grep(\"\\\\.Rd\", all_files, invert = TRUE, value = TRUE)
#>   # ignore .Rhistory
#>   all_files <- setdiff(all_files, c(\".Rhistory\", \"README.md\"))
#> 
#>   all_dirs <- list.dirs(dir, recursive = TRUE)
#>   all_dirs <- grep(\"\\\\.Rproj\\\\.user\", all_dirs, invert = TRUE, value = TRUE)
#>   all_dirs <- grep(\"\\\\.git\", all_dirs, invert = TRUE, value = TRUE)
#>   all_dirs <- setdiff(all_dirs, c(\".\", \"man\"))
#> 
#> 
#>   script_dirs <- sprintf('dir.create(\"%s\")', all_dirs)
#>   script_dirs <- c(sprintf(\"#### create dirs %s\\n\", strrep(\"-\", 63)), script_dirs)
#>   script_dirs <- paste(script_dirs, collapse = \"\\n\")
#>   script_files <- sprintf(
#>     '\\n#### %s %s\\n\\nwriteLines(con = \"%s\", \"%s\")\\n',
#>     all_files,
#>     strrep(\"-\", 74 - nchar(all_files)),
#>     all_files,
#>     vapply(all_files, function(x) {
#>       lines <- readLines(x)
#>       lines <- gsub(\"\\\\\\\\\", \"\\\\\\\\\\\\\\\\\", lines)
#>       lines <- gsub(\"\\\"\", \"\\\\\\\\\\\"\", lines)
#>       lines <- gsub(\"'\", \"\\\\'\", lines)
#>       paste(lines, collapse = \"\\n\")
#>       },
#>       FUN.VALUE = character(1))
#>   )
#>   script <- c(script_dirs, \"\\n\", script_files)
#>   cat(script, file = file)
#> }
#> 
#> is.binary <- function(file, max = 1000){
#>   f <- file(file, \"rb\", raw = TRUE)
#>   b <- readBin(f, \"int\", max, size = 1, signed = FALSE)
#>   max(b)>128
#> }")
#>  
#> #### README.Rmd ----------------------------------------------------------------
#> 
#> writeLines(con = "README.Rmd", "---
#> output: github_document
#> ---
#> 
#> ```{r, include = FALSE}
#> knitr::opts_chunk$set(
#>   collapse = TRUE,
#>   comment = \"#>\",
#>   fig.path = \"man/figures/README-\",
#>   out.width = \"100%\"
#> )
#> ```
#> 
#> # flat
#> 
#> {flat} makes your package into a script you can source to recreate it, this allows you to
#> email a flat file when emailing a compressed file is problematic.
#> 
#> It has a single function `flat::flatten_package()` that takes a package folder
#> (defaults to current folder) and an output file (defaults to printing to console).
#> 
#> {flat} is not needed on the recipient machine.
#> 
#> We ignore :
#> 
#> - hidden `.Rproj.user*` files
#> - git files
#> - binary files
#> - files under man/ (we assume they can be rebuilt with roxygen)
#> - README.md (we assume it can be rebuilt from a README.Rmd)
#> - .Rhistory
#> - testthat snapshots
#> 
#> ## Installation
#> 
#> Install with:
#> 
#> ``` r
#> devtools::install(\"moodymudskipper/flat\")
#> ```
#> 
#> ## Example
#> 
#> ```{r}
#> flat::flatten_package()
#> ```
#> ")
```
