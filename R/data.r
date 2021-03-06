#' SpatialPointsDataFrame of home locations for flow analysis.
#'
#'  These points represent population-weighted centroids of Medium Super Output Area (MSOA) zones within a 1 mile radius of of my home when I was writing this package.
#'
#' A dataset containing the prices and other attributes of almost 54,000
#'  diamonds. The variables are as follows:
#'
#' \itemize{
#'   \item geo_code. the official code of the zone
#'   \item MSOA11NM. name zone name
#'   \item percent_fem. the percent female
#'   \item avslope. average gradient of the zone
#' }
#'
#' Cents was generated from the data repository pct-data: https://github.com/npct/pct-data. This data was accessed from within the pct repo: https://github.com/npct/pct, using the following code:
#'
#' @examples
#' \dontrun{
#' cents <- rgdal::readOGR(dsn = "~/repos/pct/pct-data/national/cents.geojson", layer = "OGRGeoJSON")
#' # library(geojsonio) # load with the ropensci package geojsonio if rgdal fails
#' # cents <- geojsonio::geojson_read(x = "~/repos/pct/pct-data/national/cents.geojson")
#' crs <- CRS("+init=epsg:4326")
#' crsuk <- CRS("+init=epsg:27700")
#' cents <- sp::spTransform(x = cents, CRSobj = crsuk)
#' home <- ggmap::geocode("LS7 3HB")
#' home <- sp::SpatialPoints(coords = home, proj4string = crs)
#' home <- sp::spTransform(x = home, CRSobj = crsuk)
#' buf <- rgeos::gBuffer(home, width = 2000)
#' # Check it saved the points OK
#' cents <- cents[buf,]
#' plot(buf)
#' points(cents)
#' cents <- sp::spTransform(x = cents, CRSobj = crs)
#' library(devtools)
#' use_data(cents)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name cents
#' @usage data(cents)
#' @format A SpatialPoints with 8 rows and 5 variables
NULL

#' data frame of commuter flows
#'
#' @family example flow data
#'
#' This dataset represents commuter flows (work travel) between origin
#' and destination zones (see \code{\link{cents}}).
#' The data is from the UK and is available as open data:
#' \url{http://wicid.ukdataservice.ac.uk/}.
#'
#' The variables are as follows:
#'
#' \itemize{
#'   \item Area.of.residence. id of origin zone
#'   \item Area.of.workplace id of destination zone
#'   \item All. Travel to work flows by all modes
#'   \item [,4:15]. Flows for different modes
#'   \item id. unique id of flow
#' }
#'
#' Although these variable names are unique to UK data, the data
#' structure is generalisable and typical of flow data from any source.
#' The key variables are the origin and destination ids, which link to
#' the \code{cents} georeferenced spatial objects.
#'
#' @examples
#' \dontrun{
#' flow <- readRDS("~/repos/pct/pct-data/national/flow.Rds")
#' data(cents)
#' o <- flow$Area.of.residence %in% cents$geo_code[-1]
#' d <- flow$Area.of.workplace %in% cents$geo_code[-1]
#' flow <- flow[o & d, ] # subset flows with o and d in study area
#' library(devtools)
#' flow$id <- paste(flow$Area.of.residence, flow$Area.of.workplace)
#' use_data(flow, overwrite = T)
#'
#' # Convert flows to SpatialLinesDataFrame
#' flowlines <- gFlow2line(flow = flow, zones = cents)
#' use_data(flowlines)
#'
#' # Convert flows to routes
#' routes_fast <- gLines2CyclePath(l = flowlines, plan = "fastest")
#' routes_slow <- gLines2CyclePath(l = flowlines, plan = "quietest")
#'
#' use_data(routes_fast)
#' use_data(routes_slow)
#' }
#'
#' @docType data
#' @keywords datasets
#' @name flow
#' @usage data(flow)
#' @format A data frame with 49 rows and 15 columns
NULL


#' SpatialLinesDataFrame of commuter flows
#'
#' @family example flow data
#'
#' Flow data after conversion to a spatial format
#' with \code{\link{gFlow2line}} (see \code{\link{flow}}).
#'
#' @docType data
#' @keywords datasets
#' @name flowlines
#' @usage data(flowlines)
#' @format A SpatialLinesDataFrame 49 rows and 15 columns
NULL



#' SpatialLinesDataFrame of commuter flows on the travel network
#'
#' @family example flow data
#'
#' Simulated travel route allocated to the transport network
#' representing the 'fastest' between \code{\link{cents}}
#' objects
#' with \code{\link{gFlow2line}} (see \code{\link{flow}}).
#'
#' @docType data
#' @keywords datasets
#' @name routes_fast
#' @usage data(routes_fast)
#' @format A SpatialLinesDataFrame 49 rows and 15 columns
NULL

#' SpatialLinesDataFrame of commuter flows on the travel network
#'
#' @family example flow data
#'
#' Simulated travel route allocated to the transport network
#' representing the 'quietest' between \code{\link{cents}()}
#' objects
#' with \code{\link{gFlow2line}} (see \code{\link{flow}}).
#'
#' @docType data
#' @keywords datasets
#' @name routes_slow
#' @usage data(routes_slow)
#' @format A SpatialLinesDataFrame 49 rows and 15 columns
NULL