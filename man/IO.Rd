% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/import_export.R, R/compression.R
\name{IO}
\alias{IO}
\alias{export}
\alias{export,ANY,connection,character-method}
\alias{export,ANY,connection,missing-method}
\alias{export,ANY,missing,character-method}
\alias{export,ANY,character,missing-method}
\alias{export,ANY,character,character-method}
\alias{import}
\alias{import,connection,character,ANY-method}
\alias{import,connection,missing,ANY-method}
\alias{import,character,missing,ANY-method}
\alias{import,character,character,ANY-method}
\alias{import,missing,ANY,character-method}
\alias{import,CompressedFile,missing,ANY-method}
\alias{export,ANY,CompressedFile,missing-method}
\title{Import and export}
\usage{
import(con, format, text, ...)

\S4method{import}{connection,character,ANY}(con, format, text, ...)

\S4method{import}{connection,missing,ANY}(con, format, text, ...)

\S4method{import}{character,missing,ANY}(con, format, text, ...)

\S4method{import}{character,character,ANY}(con, format, text, ...)

\S4method{import}{missing,ANY,character}(con, format, text, ...)

export(object, con, format, ...)

\S4method{export}{ANY,connection,character}(object, con, format, ...)

\S4method{export}{ANY,connection,missing}(object, con, format, ...)

\S4method{export}{ANY,missing,character}(object, con, format, ...)

\S4method{export}{ANY,character,missing}(object, con, format, ...)

\S4method{export}{ANY,character,character}(object, con, format, ...)

\S4method{import}{CompressedFile,missing,ANY}(con, format, text, ...)

\S4method{export}{ANY,CompressedFile,missing}(object, con, format, ...)
}
\arguments{
\item{con}{The connection from which data is loaded or to which data is
saved. If this is a \code{character} vector, it is assumed to be a file name and
a corresponding file connection is created and then closed after exporting
the object. If it is a \linkS4class{BiocFile} derivative, the data is loaded from
or saved to the underlying resource. If missing, the function will return
the output as a character vector, rather than writing to a connection.}

\item{format}{The format of the output. If missing and \code{con} is a
file name, the format is derived from the file extension. This argument is
unnecessary when \code{con} is a derivative of \linkS4class{BiocFile}.}

\item{text}{If \code{con} is missing, this can be a character vector directly
providing the string data to import.}

\item{...}{Parameters to pass to the format-specific method.}

\item{object}{The object to export.}
}
\value{
If \code{con} is missing, a character vector containing the string output.
Otherwise, nothing is returned.
}
\description{
The functions \code{import} and \code{export} load and save objects from
and to particular file formats.
}
\examples{
## To illustrate export(), import(), and yeild(), we create a class, CSVFILE
.CSVFile <- setClass("CSVFile", contains = "BiocFile")

## Constructor
CSVFile <- function(resource) {
    .CSVFile(resource = resource)
}

## Define import
setMethod("import", "CSVFile",
    function(con, format, text, ...) {
        read.csv(resource(con), ...)
    }
)

## Define export
setMethod("export", c("data.frame", "CSVFile"),
    function(object, con, format, ...) {
        write.csv(object, resource(con), ...)
    }
)

## Usage
temp <- tempfile(fileext = ".csv")
csv <- CSVFile(temp)

export(mtcars, csv)
df <- import(csv)

}
\seealso{
Format-specific options for the popular formats:
\acronym{\link[rtracklayer:GFFFile]{GFF}},
\acronym{\link[rtracklayer:BEDFile]{BED}},
\acronym{\link[rtracklayer:BED15File]{Bed15}},
\acronym{\link[rtracklayer:BEDGraphFile]{bedGraph}},
\acronym{\link[rtracklayer:WIGFile]{WIG}},
\acronym{\link[rtracklayer:BigWigFile]{BigWig}}
}
\author{
Michael Lawrence
}
\keyword{IO}
