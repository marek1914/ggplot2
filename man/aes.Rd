% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aes.r
\name{aes}
\alias{aes}
\title{Construct aesthetic mappings}
\usage{
aes(x, y, ...)
}
\arguments{
\item{x, y, ...}{List of name value pairs giving aesthetics to map to
variables. The names for x and y aesthetics are typically omitted because
they are so common; all other aesthetics must be named.}
}
\description{
Aesthetic mappings describe how variables in the data are mapped to visual
properties (aesthetics) of geoms. Aesthetic mappings can be set in
\code{\link[=ggplot2]{ggplot2()}} and in individual layers.
}
\details{
This function also standardise aesthetic names by performing partial
matching, converting color to colour, and translating old style R names to
ggplot names (eg. pch to shape, cex to size).
}
\section{Quasiquotation}{


\code{aes()} is a \link[rlang:quotation]{quoting function}. This means that
its inputs are quoted to be evaluated in the context of the
data. This makes it easy to work with variables from the data frame
because you can name those directly. The flip side is that you have
to use \link[rlang:quasiquotation]{quasiquotation} to program with
\code{aes()}. See a tidy evaluation tutorial such as the \href{http://dplyr.tidyverse.org/articles/programming.html}{dplyr programming vignette}
to learn more about these techniques.
}

\examples{
aes(x = mpg, y = wt)
aes(mpg, wt)

# You can also map aesthetics to functions of variables
aes(x = mpg ^ 2, y = wt / cyl)

# Aesthetic names are automatically standardised
aes(col = x)
aes(fg = x)
aes(color = x)
aes(colour = x)

# aes is almost always used with ggplot() or a layer
ggplot(mpg, aes(displ, hwy)) + geom_point()
ggplot(mpg) + geom_point(aes(displ, hwy))

# Aesthetics supplied to ggplot() are used as defaults for every layer
# you can override them, or supply different aesthetics for each layer


# aes() is a quoting function, so you need to use tidy evaluation
# techniques to create wrappers around ggplot2 pipelines. The
# simplest case occurs when your wrapper takes dots:
scatter_by <- function(data, ...) {
  ggplot(data) + geom_point(aes(...))
}
scatter_by(mtcars, disp, drat)

# If your wrapper has a more specific interface with named arguments,
# you need to use the "enquote and unquote" technique:
scatter_by <- function(data, x, y) {
  ggplot(data) + geom_point(aes(!!enquo(x), !!enquo(y)))
}
scatter_by(mtcars, disp, drat)

# Note that users of your wrapper can use their own functions in the
# quoted expressions and all will resolve as it should!
cut3 <- function(x) cut_number(x, 3)
scatter_by(mtcars, cut3(disp), drat)
}
\seealso{
\code{\link[=vars]{vars()}} for another quoting function designed for
faceting specifications.
}
