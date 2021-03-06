% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/data.r
\docType{data}
\name{flow}
\alias{flow}
\title{data frame of commuter flows}
\format{A data frame with 49 rows and 15 columns}
\usage{
data(flow)
}
\description{
data frame of commuter flows
}
\examples{
\dontrun{
flow <- readRDS("~/repos/pct/pct-data/national/flow.Rds")
data(cents)
o <- flow$Area.of.residence \%in\% cents$geo_code[-1]
d <- flow$Area.of.workplace \%in\% cents$geo_code[-1]
flow <- flow[o & d, ] # subset flows with o and d in study area
library(devtools)
flow$id <- paste(flow$Area.of.residence, flow$Area.of.workplace)
use_data(flow, overwrite = T)

# Convert flows to SpatialLinesDataFrame
flowlines <- gFlow2line(flow = flow, zones = cents)
use_data(flowlines)

# Convert flows to routes
routes_fast <- gLines2CyclePath(l = flowlines, plan = "fastest")
routes_slow <- gLines2CyclePath(l = flowlines, plan = "quietest")

use_data(routes_fast)
use_data(routes_slow)
}
}
\seealso{
Other res: \code{\link{flowlines}};
  \code{\link{routes_fast}}; \code{\link{routes_slow}}
}
\keyword{datasets}

